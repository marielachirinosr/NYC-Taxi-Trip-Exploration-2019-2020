# This section contains URLs to the large files stored on Google Drive
    #'https://drive.google.com/drive/folders/1Pr6r1Xo87Ig-2TW79iHGgnSwEWGtAVju?usp=drive_link'
# This code demonstrates data processing using a subset, as working with the full dataset
# In local memory can be resource-intensive. For large-scale processing, we've moved to BigQuery.

import pandas as pd 
from pandasql import sqldf

# Step 1: Read taxi zone lookup data
taxi_zone = pd.read_csv('taxi_zone_lookup.csv')

# Step 2: Read CSV file into memory
data_2019_01 = 'yellow_tripdata_2019_01.csv' 
tripdata_2019_01 = pd.read_csv(data_2019_01, low_memory=False)
print("CSV in memory: ", data_2019_01)

# Step 3: Create a subset of data
subset_tripdata_2019_01 = tripdata_2019_01.head(1000)

# Step 4: Format the date 
print("Format date: ", data_2019_01)
subset_tripdata_2019_01['tpep_pickup_datetime'] = pd.to_datetime(subset_tripdata_2019_01['tpep_pickup_datetime'], format='%Y-%m-%d %H:%M:%S', errors='coerce')
subset_tripdata_2019_01['tpep_dropoff_datetime'] = pd.to_datetime(subset_tripdata_2019_01['tpep_dropoff_datetime'], format='%Y-%m-%d %H:%M:%S', errors='coerce')

# Step 5: Fill NaN values in congestion_surcharge with 0
print("Fill NaN: ", data_2019_01)
subset_tripdata_2019_01['congestion_surcharge'] = subset_tripdata_2019_01['congestion_surcharge'].fillna(0)

# Step 6: Drop null and duplicate values
print("Drop Null and duplicates: ", data_2019_01)
subset_tripdata_2019_01 = subset_tripdata_2019_01.drop_duplicates()
subset_tripdata_2019_01 = subset_tripdata_2019_01.dropna()

# Step 7: Calculate trip duration
def get_string_from_duration_in_seconds(x):
    return '{:02}:{:02}:{:02}'.format(int(x // 3600), int((x % 3600) // 60), int(x % 60))

print("Calculating trip duration: ", data_2019_01)
subset_tripdata_2019_01['trip_duration_time'] = subset_tripdata_2019_01['tpep_dropoff_datetime'] - subset_tripdata_2019_01['tpep_pickup_datetime']
subset_tripdata_2019_01['trip_duration_time'] = subset_tripdata_2019_01['trip_duration_time'] \
    .dt \
    .total_seconds() \
    .astype(int) \
    .apply(get_string_from_duration_in_seconds)

# Step 8: Calculate speed
print('Calculate speed: ', data_2019_01)
subset_tripdata_2019_01['speed_mph'] = subset_tripdata_2019_01['trip_distance'] / (pd.to_timedelta(subset_tripdata_2019_01['trip_duration_time']).dt.total_seconds() / 3600)

# Step 9: Extract day of week 
subset_tripdata_2019_01['day_of_week_name'] = subset_tripdata_2019_01['tpep_pickup_datetime'].dt.day_name()
subset_tripdata_2019_01['day_of_week'] = subset_tripdata_2019_01['tpep_pickup_datetime'].dt.dayofweek

# Step 10: Categorize time of day 
subset_tripdata_2019_01['time_of_day'] = pd.cut(subset_tripdata_2019_01['tpep_pickup_datetime'].dt.hour, bins=[0, 6, 12, 18, 24], labels=['Night', 'Morning', 'Afternoon', 'Evening'], right=False)

# Step 11: Join and add zone name by ID
print("Join and add zones: ", data_2019_01)
subset_tripdata_2019_01 = sqldf("""
    SELECT a.*, b.Borough AS PUBorough, b.Zone AS PUZone, b.service_zone AS PUServiceZone,
        c.Borough AS DOBorough, c.Zone AS DOZone, c.service_zone AS DOServiceZone
    FROM subset_tripdata_2019_01 a
    LEFT JOIN taxi_zone b ON a.PULocationID = b.LocationID
    LEFT JOIN taxi_zone c ON a.DOLocationID = c.LocationID
""")

# Step 12: Organize columns
print("Generating result for trip data: ", data_2019_01)
subset_tripdata_2019_01.to_csv(f'trip_result_{data_2019_01}', index=False)

# Step 13: Query average trip metrics
query = """
    SELECT 
        strftime('%Y', tpep_pickup_datetime) as pickup_year,
        strftime('%m', tpep_pickup_datetime) as pickup_month,
        strftime('%w', tpep_pickup_datetime) as day_of_week,
        COUNT(*) as trip_count,
        AVG(fare_amount) as avg_fare_amount,
        AVG(tip_amount) as avg_tip_amount,
        time_of_day
    FROM subset_tripdata_2019_01
    GROUP BY pickup_year, pickup_month, day_of_week, time_of_day
"""
print("Querying averages: ", data_2019_01)
result = sqldf(query, locals())

# Step 14: Save averages to CSV
print("Averages to CSV: ", data_2019_01)
result.to_csv(f'avgs_{data_2019_01}', index=False)

print("End: ", data_2019_01, "\n\n")

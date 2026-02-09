- Question 3. Counting short trips
SELECT COUNT(*) AS total_count
FROM green_taxi_trip
WHERE lpep_pickup_datetime >= '2025-11-01'
  AND lpep_pickup_datetime <  '2025-12-01'
  AND trip_distance <= 1;

-- Question 4. Longest trip for each day
SELECT lpep_pickup_datetime, trip_distance
FROM green_taxi_trip
WHERE trip_distance < 100
ORDER BY trip_distance DESC
LIMIT 1;

-- Question 5. Biggest pickup zone
SELECT z."Zone", COUNT(gtt.lpep_pickup_datetime) AS total_amount
FROM green_taxi_trip gtt
JOIN "zone" z ON gtt."PULocationID" = z."LocationID"
WHERE gtt.lpep_pickup_datetime::date = '2025-11-18'
GROUP BY z."Zone"
ORDER BY total_amount DESC;

-- Question 5. Biggest pickup zone
SELECT z."Zone", COUNT(gtt.lpep_pickup_datetime) AS total_amount
FROM green_taxi_trip gtt
JOIN "zone" z ON gtt."PULocationID" = z."LocationID"
WHERE gtt.lpep_pickup_datetime >= '2025-11-18'
  AND lpep_pickup_datetime <  '2025-11-19'
GROUP BY z."Zone"
ORDER BY total_amount DESC;


-- Question 6. Largest tip
SELECT 
    gtt."DOLocationID",
    dz."Zone" AS dropoff_zone,
    gtt.tip_amount
FROM green_taxi_trip gtt
JOIN "zone" dz ON gtt."DOLocationID" = dz."LocationID"
WHERE gtt.lpep_pickup_datetime >= '2025-11-01'
  AND gtt.lpep_pickup_datetime < '2025-12-01'
  AND gtt."PULocationID" = 74
ORDER BY gtt.tip_amount DESC
LIMIT 1;

-- Question 6. Largest tip (more dynamic)
SELECT 
    gtt."DOLocationID",
    dz."Zone" AS dropoff_zone,
    gtt.tip_amount
FROM green_taxi_trip gtt
JOIN "zone" pz ON gtt."PULocationID" = pz."LocationID"
JOIN "zone" dz ON gtt."DOLocationID" = dz."LocationID"
WHERE gtt.lpep_pickup_datetime >= '2025-11-01'
  AND gtt.lpep_pickup_datetime < '2025-12-01'
  AND pz."Zone" = 'East Harlem North'
ORDER BY gtt.tip_amount DESC
LIMIT 1;
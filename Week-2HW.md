Lohitha Vanteru HW #2 Answers
Question 1.
Within the execution for Yellow Taxi data for the year 2020 and month 12: what is the uncompressed file size (i.e. the output file yellow_tripdata_2020-12.csv of the extract task)?

128.3 MB
134.5 MB
364.7 MB
692.6 MB

## ⚠️ Important Note  
If you are purging the file at the end of the process, ensure you check this during execution; otherwise, the file size will be **0**!  

## 📂 File Location  
- **Kestra → Executions → Output**  
- Look for: **yellow 12/2020**  
- Path: **extract | outputFiles | yellow-tripdata_2020-12.csv**  
- File Size: **128.3 MiB**  

## ❓ MiB vs MB  
- **MiB (Mebibytes)**: Used in computing, based on powers of 2 (1 MiB = 1,048,576 bytes).  
- **MB (Megabytes)**: Used in standard metric (1 MB = 1,000,000 bytes).  
- **Key Difference**: 1 MiB ≈ 1.05 MB.  

Question 2.
What is the rendered value of the variable file when the inputs taxi is set to green, year is set to 2020, and month is set to 04 during execution?

{{inputs.taxi}}_tripdata_{{inputs.year}}-{{inputs.month}}.csv
green_tripdata_2020-04.csv
green_tripdata_04_2020.csv
green_tripdata_2020.csv

## 📝 Determining the Rendered Value of `file`  

### Given Inputs:  
- `taxi = green`  
- `year = 2020`  
- `month = 04`  

### File Naming Convention:  
In Kestra, the `file` variable is typically structured as:  

```plaintext
{taxi}-tripdata_{year}-{month}.csv


## 🔎 Questions 3-5  

To determine the number of rows for these questions, we need to navigate to our **BigQuery** section and check the **Details** tab.   

Question 3.
How many rows are there for the Yellow Taxi data for all CSV files in the year 2020?

13,537.299
24,648,499
18,324,219
29,430,127


Question 4.
How many rows are there for the Green Taxi data for all CSV files in the year 2020?

5,327,301
936,199
1,734,051
1,342,034

Question 5.
How many rows are there for the Yellow Taxi data for the March 2021 CSV file?

1,428,092
706,911
1,925,152
2,561,031


Question 6.
How would you configure the timezone to New York in a Schedule trigger?

Add a timezone property set to EST in the Schedule trigger configuration
Add a timezone property set to America/New_York in the Schedule trigger configuration
Add a timezone property set to UTC-5 in the Schedule trigger configuration
Add a location property set to New_York in the Schedule trigger configuration

🔍 Explanation:  
- The correct way to define time zones in **Kestra** (and most systems using time zones) is to use the **IANA Time Zone Database format** (e.g., `America/New_York`).  
- `EST` is not a valid time zone name in many configurations because it does not account for **Daylight Saving Time (DST)**.  
- `UTC-5` is a fixed offset and does not dynamically adjust for DST.  
- `location` is not a recognized property for defining time zones in Kestra.  

By using `America/New_York`, the system will correctly handle **Eastern Standard Time (EST)** and **Eastern Daylight Time (EDT)** based on the time of year.  

# README.md

## E-commerce Data Pipeline Setup and Execution Guide

This document provides a step-by-step guide to setting up the environment and executing the necessary files to process and transform data for the e-commerce data pipeline. Follow these instructions carefully to ensure successful execution.

### Prerequisites

- Python 3.x installed on your machine
- Google Cloud SDK installed and authenticated
- Google BigQuery access and credentials set up

### Step 1: Create a Virtual Environment

1. Open your terminal or command prompt.
2. Navigate to your project directory.
3. Create a virtual environment named `dataproc_env` by running the following command:

    ```bash
    python -m venv dataproc_env
    ```

4. Activate the virtual environment:
    - On Windows:

        ```bash
        .\dataproc_env\Scripts\activate
        ```

    - On macOS/Linux:

        ```bash
        source dataproc_env/bin/activate
        ```

### Step 2: Install Dependencies

1. Ensure you are in the root directory of your project.
2. Install the required dependencies by running:

    ```bash
    pip install -r requirements.txt
    ```

### Step 3: Install and Authenticate Google Cloud SDK

1. **Install Google Cloud SDK**:
    - Follow the instructions to install the Google Cloud SDK from [Google Cloud SDK installation guide](https://cloud.google.com/sdk/docs/install).

2. **Authenticate with Google Cloud**:
    - Open your terminal or command prompt.
    - Run the following command to authenticate your Google Cloud account and set up the Application Default Credentials (ADC):

      ```bash
      gcloud auth application-default login
      ```

      Follow the prompts to complete the authentication.

      OR Put the configuration file path in the main.tf file inside the terraform folder

### Step 4: Extract, Validate, and Clean Data

1. Open and run the `Extract_validate_and_clean_data.ipynb` notebook.
2. This notebook will execute the data extraction, validation, and cleaning process.
3. Upon completion, a folder named `Processed_data` will be created in the root directory with the following subfolders:
    - `cleaned_data`: Contains the cleaned data files.
    - `bad_data`: Contains the invalid data files.





### Step 5: Infrastructure as Code

To set up the BigQuery resources using Terraform:

1. Navigate to the `terraform` directory:
    ```bash
    cd terraform
    ```

2. Initialize Terraform:
    ```bash
    terraform init
    ```

3. Apply the Terraform configuration:
    ```bash
    terraform apply
    ```

    You will be prompted to confirm the creation of the resources. Type `yes` to proceed. This step sets up the BigQuery dataset and tables as defined in the Terraform configuration files.


### Step 6: Transform Data into Data Model and Store it into Data Warehouse

1. Open and run the `Transform_into_data_model.ipynb` notebook.
2. This notebook will:
    - Take the files from the `cleaned_data` folder.
    - Create the data model (Dimensions and Facts).
    - Load the dimension and fact tables into the Google BigQuery warehouse.

### Analytics Queries

Example queries are provided to aggregate relevant data:

1. **Total Sales by Category**:
    ```sql
    SELECT 
        i.category, 
        SUM(o.amount) AS total_sales
    FROM 
        `project_id.dataset_id.Orders` o
    JOIN 
        `project_id.dataset_id.Inventory` i
    ON 
        o.productId = i.productId
    GROUP BY 
        i.category
    ORDER BY 
        total_sales DESC;
    ```

2. **Average Order Value by Channel**:
    ```sql
    SELECT 
        o.channel, 
        AVG(o.amount) AS average_order_value
    FROM 
        `project_id.dataset_id.Orders` o
    GROUP BY 
        o.channel
    ORDER BY 
        average_order_value DESC;
    ```

3. **Top-Selling Products by Quantity**:
    ```sql
    SELECT 
        i.name, 
        SUM(o.quantity) AS total_quantity
    FROM 
        `project_id.dataset_id.Orders` o
    JOIN 
        `project_id.dataset_id.Inventory` i
    ON 
        o.productId = i.productId
    WHERE 
        i.isCurrent = TRUE
    GROUP BY 
        i.name
    ORDER BY 
        total_quantity DESC
    LIMIT 10;
    ```

### Future Improvements

- Implement additional data validation checks.
- Use Dbt for Transformation
- Building a robust testing pipeline
- Use advanced features of BigQuery like partitioning and clustering.


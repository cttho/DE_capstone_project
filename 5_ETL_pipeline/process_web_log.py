from datetime import timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.utils.dates import days_ago

# defining DAG arguments
default_args = {
    'owner': 'Tony Staz',
    'start_date': days_ago(0),
    'email': ['tonystaz@fakemail.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# defining the DAG
dag = DAG(
    'process_web_log', 
    default_args=default_args,
    description='Analyzing the web server log file DAG',
    schedule_interval=timedelta(days=1)
)

# create a task to extract data
extract_data = BashOperator(
    task_id='extract_data',
    bash_command='cut -d" " -f1 ${AIRFLOW_HOME}/dags/capstone/accesslog.txt > ${AIRFLOW_HOME}/dags/capstone/extracted_data.txt',
    dag=dag
)

# create a task to remove "198.46.149.143" from extracted_data.txt
transform_data = BashOperator(
    task_id='transform_data',
    bash_command='grep -v "198.46.149.143" ${AIRFLOW_HOME}/dags/capstone/extracted_data.txt > ${AIRFLOW_HOME}/dags/capstone/transformed_data.txt',
    dag=dag
)

# create a task to load the data by compress it
load_data = BashOperator(
    task_id='load_data',
    bash_command='tar -cvf ${AIRFLOW_HOME}/dags/capstone/weblog.tar ${AIRFLOW_HOME}/dags/capstone/transformed_data.txt',
    dag=dag
)

# task pipeline
extract_data >> transform_data >> load_data
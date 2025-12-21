import pandas as pd 

df = pd.read_csv('Sales Dataset.csv')
print(df.head())
print(df.tail()) 

# Understanding The Data Set.
df.info()
print(df.describe())

# Null Value
print(df.isnull().sum())

# Columns
df.columns = df.columns.str.lower()
df.columns = df.columns.str.replace(' ','_')
df.rename(columns={
    'Sub-Category':'sub_category',
    'PaymentMode' : 'payment_mode',
    'CustomerName': 'customer_name'
},inplace=True) 

print(df.columns)

df['order_date'] = pd.to_datetime(df['order_date'],dayfirst=True)
df['Year'] = df['order_date'].dt.year 
df['Months'] = df['order_date'].dt.month




import pandas as pd
import matplotlib.pyplot as plt
df=pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\cleaned budget.csv")
categories=["a_food","a_trans","a_entertainment","a_other"]
category_totals=df[categories].sum()
plt.figure(figsize=(7,7))
plt.pie(category_totals,labels=category_totals.index,autopct='%1.1f%%',startangle=90,shadow=True,)
plt.title("spending distribution",fontsize=14,fontweight="bold")
plt.tight_layout()
plt.show()
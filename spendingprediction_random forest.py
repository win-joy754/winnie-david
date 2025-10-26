import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error,r2_score
import joblib
df=pd.read_csv(r"C:\Users\admin\OneDrive\Desktop\cleaned budget.csv")
df=df.fillna(0)
df["total_spending"]=df[["a_food","a_trans","a_entertainment","a_other","b_bills","b_rent"]].sum(axis=1)
X=df[["income","week_number"]]
y=df["total_spending"]
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2,random_state=42)
model=RandomForestRegressor(n_estimators=30,random_state=42)
model.fit(X_train,y_train)
y_pred=model.predict(X_test)
mse=mean_squared_error(y_test,y_pred)
r2=r2_score(y_test,y_pred)
print("model trained successfully")
print(f"mean squared error:(mse)",mse)
print(f"R^2 score:",r2)
joblib.dump(model,"spending_prediction-rf.pkl")
print("model saved")
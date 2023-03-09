import pandas as pd
import tletools as tle

"""
Up-to date satcat pulled from this link and downloaded: 
https://www.space-track.org/basicspacedata/query/class/gp/EPOCH/%3Enow-30/orderby/NORAD_CAT_ID,EPOCH/format/3le 
"""
file_location = "C:/Users/Benjamin/Downloads/satcat-full.txt"
file_destination = "C:/Users/Benjamin/Documents/Trinity Documents/Programming Project/Project/Project/Data/satcat.tsv"


df = tle.pandas.load_dataframe(file_location)
df.to_csv(file_destination, sep="\t")


file_gcat = "C:/Users/Benjamin/Documents/Trinity Documents/Programming Project/Project/Project/Data/gcat.tsv"
file_satcat = "C:/Users/Benjamin/Documents/Trinity Documents/Programming Project/Project/Project/Data/satcat.tsv"
file_destination = "C:/Users/Benjamin/Documents/Trinity Documents/Programming Project/Project/Project/Data/active-satelites.tsv"
gcat = pd.read_csv(file_gcat, sep='\t',dtype='string')
satcat = pd.read_csv(file_satcat, sep='\t',dtype='string')

#this is going to have all satelites currently orbiting
satcat.drop('name', inplace=True, axis=1)
satcat.drop('classification', inplace=True, axis=1)
satcat.drop('int_desig', inplace=True, axis=1)
satcat.drop('epoch_year', inplace=True, axis=1)
satcat.drop('epoch_day', inplace=True, axis=1)
satcat.drop('dn_o2', inplace=True, axis=1)
satcat.drop('ddn_o6', inplace=True, axis=1)
satcat.drop('bstar', inplace=True, axis=1)
satcat.drop('set_num', inplace=True, axis=1)
satcat.drop('inc', inplace=True, axis=1)
satcat.drop('argp', inplace=True, axis=1)
satcat.drop('M', inplace=True, axis=1)
satcat.drop('n', inplace=True, axis=1)
satcat.drop('rev_num', inplace=True, axis=1)
satcat.drop('epoch', inplace=True, axis=1)
temp1 = satcat.loc[satcat['norad'].isin(gcat['Satcat'])]
temp1['norad'] = pd.to_numeric(temp1['norad'],downcast='integer')
temp1.rename(columns = {'norad':'Satcat'},inplace=True)
temp1.set_index("Satcat",inplace=True)
temp1.sort_index(inplace=True)

temp2 = gcat.loc[gcat['Satcat'].isin(satcat['norad'])]
temp2['Satcat'] = pd.to_numeric(temp2['Satcat'],downcast='integer')
temp2.set_index("Satcat",inplace=True)
temp2.sort_index(inplace= True)
print(temp1)
print(temp2)
new_df = pd.concat([temp1, temp2], axis=1)
print(type(satcat))

#new_df.dropna(subset=['#JCAT'],inplace=True)
print(len(new_df))


new_df.to_csv(file_destination, sep="\t")

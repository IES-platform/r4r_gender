import pandas as pd
import requests
from io import StringIO
import string
from unidecode import unidecode
pd.options.mode.chained_assignment = None
import numpy as np
import re
import unicodedata as ud

def read_wgnd(path = False, All = True):
    if  path == False and All == True :
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750348').content
        d1 = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
        print('saving first dictionnary.')
        d1.to_csv("d1.csv.gz", index=False, compression="gzip") 
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750350').content
        d2 = pd.read_csv(StringIO(s.decode('utf-8')),sep = ',')
        d2.to_csv( "d2.csv.gz", index=False, compression="gzip") 
        print('saving second dictionnary.')
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750351').content
        d3 = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
        d3.to_csv("d3.csv.gz", index=False, compression="gzip")
        print('saving third dictionnary.')
    elif path != False and All == True:
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750348').content
        d1 = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
        print('saving first dictionnary.')
        d1.to_csv(path + "d1.csv.gz", index=False, compression="gzip") 
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750350').content
        d2 = pd.read_csv(StringIO(s.decode('utf-8')),sep = ',')
        d2.to_csv(path + "d2.csv.gz", index=False, compression="gzip") 
        print('saving second dictionnary.')
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750351').content
        d3 = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
        d3.to_csv(path + "d3.csv.gz", index=False, compression="gzip")
        print('saving third dictionnary.')
    elif All != True:
        s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750351').content
        d3 = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
        d3.to_csv(path + "d3.csv.gz", index=False, compression="gzip")
    print ('All dictionaries saved!')

    
    
latin_letters= {}

def unique(list1):
    x = np.array(list1)
    listed  = np.unique(x)
    return listed

def is_latin(uchr):
    try: return latin_letters[uchr]
    except KeyError:
         return latin_letters.setdefault(uchr, 'LATIN' in ud.name(uchr))

def only_roman_chars(unistr):
    return all(is_latin(uchr)
           for uchr in unistr
           if uchr.isalpha()) # isalpha suggested by John Machin


    
def multi_clean_name_function(name):
    name = str(name)
    name_1 = name.lower() ## lower the letters
    name_1 = re.sub(' +', ' ', name_1) ## remove double spaces
    name_1 = name_1.strip()## remove spaces in the begining and the end
    h = only_roman_chars(name_1)
    if h == True:
        name_2 = unidecode(name_1)# remove accent
        name_3 = name_2.strip(string.punctuation)
        clean_names = [name_1, name_2, name_3]
        return clean_names
    else:
        return name_1
    
def clean_country_function(country_code):
    country_code = country_code.upper()
    country_code = country_code.translate(str.maketrans('', '', string.punctuation))
    country_code = unidecode(country_code)
    country_code = ''.join([i for i in country_code if not i.isdigit()])
    return country_code


def reading_wgnd (dictionnary, path):
    if dictionnary == 1:
        try: 
            print("reading the dictionnary.")
            data = pd.read_csv(path + 'd1.csv.gz', compression="gzip" ) ### find a way to change to local path        
        except:
            print("downloading the dictionnary.")
            s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750348').content
            data = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
    if dictionnary == 2:
        try:    
            print("reading the dictionnary.")
            data = pd.concat(map(pd.read_csv, [path + 'd2_1.csv.gz',path + 'd2_2.csv.gz',path + 'd2_3.csv.gz']))
        except:
            print("downloading the dictionnary.")
            s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750350').content
            data = pd.read_csv(StringIO(s.decode('utf-8')),sep = ',')
    if dictionnary == 3:
        try: 
            print("reading the dictionnary.")
            data = pd.read_csv(path + 'd3.csv.gz', compression="gzip" ) 
        except:
            print("downloading the dictionnary.")
            s = requests.get('https://dataverse.harvard.edu/api/access/datafile/4750351').content
            data = pd.read_csv(StringIO(s.decode('utf-8')),sep = '\t')
    return data



def get_gender(df, name_column, country_column = False,  split = True, split_sep = ' ', treshold = 0.6, path = 'dictionaries/'): 
    df = df.reset_index(drop=True) ### in case of multiple index
    df = df.reset_index(names = 'name_id') ### we need the name_id to reconnect to final results
    original = df.copy()
    if country_column != False:
        df = df[['name_id',name_column, country_column]]
    else:
        df = df[['name_id',name_column]]
    df['clean_name'] = df.apply(lambda x: multi_clean_name_function(x[name_column]), axis = 1 )
    del df[name_column]
    df = df.explode('clean_name')
    if split == True:
        df['clean_name'] = df['clean_name'].str.split(split_sep)
        df = df.explode('clean_name')
        df['surname_position'] = df.groupby('name_id').cumcount() + 1
    if country_column != False:
        dff = df[~(df[country_column].isnull())]
        dff [country_column] = dff [country_column].astype(str)
        dff ['clean_country_column'] =  dff[country_column].apply(lambda x: clean_country_function(x) )
        del dff [country_column]
        dfn = df[(df[country_column].isnull())]
        del df
        del dfn[country_column]
    else:
        dfn = df.copy()
        del df
    #######################################################################################################################
    ############################################################################ FIRST TRY
    #######################################################################################################################
    if country_column != False:
        print('Step 1 - reading the name-country-gender dictionary')
        data = reading_wgnd (1, path)
        data = data.rename(columns = {'name':'clean_name','code':'clean_country_column'})
        data = data [data['clean_name'].isin(list(dff['clean_name']))]
        data = data [data['clean_country_column'].isin(list(dff['clean_country_column']))]
        cols = unique(data['gender'].tolist())
        data = data.drop_duplicates(subset = ('clean_name','clean_country_column'))
        data = data.pivot(index=['clean_name','clean_country_column'], columns="gender", values="wgt").reset_index()
        found = data.merge(dff, on = ('clean_name','clean_country_column'))
        found = found[(found[cols] > treshold).any(axis = 1)]
        del data
        try:
            found  = found.sort_values('surname_position', ascending = True).drop_duplicates(subset = 'name_id')
            del found['surname_position']
        except:
            found = found.drop_duplicates(subset = 'name_id')
        dff = dff [~(dff['name_id'].isin(list(found['name_id'])))]
        found['level'] = 1
        found= found.fillna(0)
        #######################################################################################################################
        ################################################################################# Second Try
        #######################################################################################################################
        print('Step 2 - reading the name-language-gender dictionary')
        data = reading_wgnd (2, path)
        data = data.rename(columns = {'name':'clean_name','code':'clean_country_column'})
        data = data [data['clean_name'].isin(list(dff['clean_name']))]
        data = data [data['clean_country_column'].isin(list(dff['clean_country_column']))]
        data = data.drop_duplicates(subset = ('clean_name','clean_country_column'))
        res = data.merge(dff, on = ('clean_name','clean_country_column'))
        res = res.sort_values('surname_position', ascending = True).drop_duplicates(subset = 'name_id')
        del res['surname_position']
        res['wgt'] = 1
        res = res.pivot(index=['clean_name','clean_country_column','name_id'], columns="gender", values="wgt").reset_index()
        res['level'] = 2
        res= res.fillna(0)
        del data
        found = pd.concat([found,res])
        dff = dff [~(dff['name_id'].isin(list(found['name_id'])))]
        del res
        if len (dff) > 0:
            try:
                dfn = pd.concat([dff, dfn])
            except:
                dfn = dff.copy()
                del dff
        #######################################################################################################################
        ######################################################################################### LAST CHANCE / Direct try
    try :
        dfn = dfn [~(dfn['name_id'].isin(list(found['name_id'])))]
    except:
        pass
    print('Step 3 - reading the name-gender dictionary.')
    data = reading_wgnd (3, path)
    data = data.rename(columns = {'name':'clean_name'})
    data = data [data['clean_name'].isin(list(dfn['clean_name']))]
    ##### Filter on relevant data
    res = data.merge(dfn, on = 'clean_name')
    del data
    res = res.sort_values('surname_position', ascending = True).drop_duplicates(subset = 'name_id')
    res['wgt'] = 1
    try:
        res = res.pivot(index=['name_id','clean_name','clean_country_column'], columns="gender", values="wgt").reset_index()
    except:
        res = res.pivot(index=['name_id','clean_name'], columns="gender", values="wgt").reset_index()
    res ['level'] = 3
    try:
        found = pd.concat([res, found])
    except:
        found = res.copy()
    not_found =  dfn [~(dfn['name_id'].isin(list(found['name_id'])))]
    not_found = not_found.drop_duplicates(subset = 'name_id')
    del res
    del dfn
    #######################################################################################################################
    ######################################################################################### MERGING RESULTS
    ########################################################################################################################
    cols = []
    try :
        not_found ['F'] = 'not found'
        found ['F']= found['F'].fillna(0)
        cols.append('F')
    except:
        pass
    try :
        not_found ['M'] =  'not found'
        found ['M']= found['M'].fillna(0)
        cols.append('M')
    except:
        pass
    try:
        not_found ['?'] =  'not found'
        found ['?']= found['?'].fillna(0)
        cols.append('?')
    except:
        pass
    found['gender'] = found[cols].idxmax(axis=1)
    res_final = pd.concat([not_found, found])
    res_final = res_final.merge(original, on = 'name_id')
    del original['name_id']
    res_final = res_final.sort_values('name_id', ascending = True)
    s =  res_final  ['name_id']
    res_final.set_index( [s, s/s])
    del res_final  ['name_id']
    res_final['gender'] = res_final['gender'].fillna('not found')
    h = res_final['gender'].value_counts()
    h = pd.DataFrame(h)
    h ['Percentage'] = ((h['gender'] / len(original))*100 )
    try:
        del res_final['clean_name']
        del res_final ['clean_country_column']
        del res_final['surname_position']
    except:
        pass
    print ('Results distirbution is as follow:','\n',h)
    cols_2 = list(original.columns) +  ['level', 'gender'] + cols
    res_final = res_final [cols_2] 
    return res_final


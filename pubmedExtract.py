'''
Created on Oct 5, 2015

@author: Akshay Prakash

This piece of code is to extract XML files from pubmed and get Title & Article
for text analysis on those pubmed titles.
'''
from Bio import Entrez
import os

# Enter email and the keyword to search from pubmed
Entrez.email="prakash_aksh@bentley.edu"
keywords = {"alzheimers[TITL]"}

#Loop to generate articles from pubmed Database, retmax is the number of articles
for key in keywords:
    data = Entrez.esearch(db="pubmed",retmax=10000, term = key, sort="pubDate")
    res=Entrez.read(data)
    PMID = res["IdList"]
    print(key)
    print(len(PMID))
    
    #Insert Directory name here: 
    directory = '/Users/AkshaysMacBookPro/Documents/PubMed_Project/'+key
    if not os.path.exists(directory):
        os.makedirs(directory)
    
    #Extract XML data
    for pubid in PMID:
        handle = Entrez.efetch(db='pubmed', id=pubid, retmode='xml')
        xml_data = Entrez.read(handle)[0]
        print(pubid)   
        try:
            #Extract Title
            article = xml_data['MedlineCitation']['Article']
            title = article['Journal']['Title']
            title = title.encode('utf-8','xmlcharrefreplace')
                
            jl = article['Journal']['JournalIssue']
            if u'Year' in jl['PubDate']:
                year = jl['PubDate']['Year']    
            else:
                year = jl['PubDate']['MedlineDate'][0:4]
                #print(year)
            directory1 = directory+"/"+year
            if not os.path.exists(directory1):
                os.makedirs(directory1)
                
                #Extract Abstract
            if u'Abstract' in article:    
                abstract = article['Abstract']['AbstractText'][0]                
                abstract = abstract.encode('utf-8','xmlcharrefreplace')
                        
            fileFullText =  directory1+'/'+pubid+'.txt'
                #print(fileFullText)
            file1 = open(fileFullText, "w")
            if(title or abstract):
                file1.write('Title:'+str(title)+'\n')
                file1.write('Abstract:'+str(abstract)+'\n')
        except:
            print("No MedlineCitation")
            
    
# Enter the year file you want all the articles to be joined
os.chdir('/Users/AkshaysMacBookPro/Documents/PubMed_Project/alzheimers[TITL]/2015/')
filenames = ['23715207.txt', '25446437.txt', '25457987.txt', '25637921.txt',
             '25741557.txt', '25746773.txt', '25771456.txt', '25773003.txt', 
             '25956321.txt', '25966615.txt', '25996736.txt', '25998001.txt', 
             '26026741.txt', '26065584.txt', '26084646.txt', '26212654.txt', 
             '26233607.txt', '26256251.txt', '26423935.txt']
             
with open('/Users/AkshaysMacBookPro/Documents/PubMed_Project/alzheimers[TITL]/2015/file_one.txt', 'w') as outfile:
    for fname in filenames:
        with open(fname) as infile:
            for line in infile:
                outfile.write(line)
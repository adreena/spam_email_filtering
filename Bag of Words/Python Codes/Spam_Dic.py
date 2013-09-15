import sys
from porter import *

# making the dictionary file
dic={}

# openning the source file
f=open('D:/Pdf/Machine Learning/project/E2/PD_source.txt','r')
source=f.read()
f.close()
i=0
for line in source.split('\n'):
    print line
    f=open(line,'r')
    text=f.read()
    f.close()
    #print 'main text'
    #print "------------------------"
    #print text
    #print "------------------------"
    # define method
    def replace_all(text, dic):
        for i, j in dic.iteritems():
            text = text.replace(j, i)
        return text
    #------------------------------------------
    # our text the replacement will take place
    #-----------------------------------------
    my_text = text
    reps = {'H':'|-|', 'free':'fr33', 'o':'0', 's':'$' , 'before':'b4'}
    text = replace_all(my_text, reps)

    #-----------------------------------------
    # some other normalizations
    #-----------------------------------------
    # this step is for omiting numbers which are attached to words  
    list1=['!','?','$',':',";","-",",","/","+","_", "~", "@","%","&","*",'(',')','#','`',"|","{","}",".",">","<","=",'"',"'","[","]"]
    for item in list1:
        for word in text.split(item):
            text=text.replace(item,' '+item+' ')
   
    list2=['1','2','3','4','5','6','7','8','9','0']
    for item in list2:
        for word in text.split(item):
            text=text.replace(item,' '+item+' ')
    text=text.lower() 

    #----------------------------------------
    # using porter
    #----------------------------------------
    p=PorterStemmer()
    for word in text.split():
        modified_word=p.stem(word, 0,len(word)-1)
        text=text.replace(word,modified_word)


   
    #----------------------------------------
    #searchin through an email
    #----------------------------------------
    list1=[]
    for word in text.split():
        list1.append(word)
    #print list1
    #print len(list1)

    newlist=set(list1)
    #print "------------------"
    #print newlist
    #print len(modfied)


    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # adding to the dic
    #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    list3=['address','subject','from','an','the','at','to','of','for','and','or','in','that','this','it','he','she','I','am','is','are','was','were','they']
    #list4=['1','2','3','4','5','6','7','8','9','0']
    list5=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    #list6=['fri','friday','sat','saturday','sun','sunday','mon','monday','tue','tuesday','wed','wednesday','thr','thursday']


    for item in newlist:
        if item in dic:
            dic[item]+=1
        else:
            if item in list3:
                t=12
            elif item in list5:
                t=12
            else :
                dic[item]=1;

for item in dic.keys():
    if len(item)<=2:
            del dic[item]

for items in dic.keys():
    if dic[items]<5:
        del dic[items]


lis=[]

for item in dic.keys():
    lis.append(item)
lis.sort()
#print lis
#w.write(lis[0])
keep=lis[0]
#del lis[0]
#lis2=[]
#for word in lis:
#    lis2.append(word)

#for word in lis2:
#    w.write('\n')
#    w.write(word)
    
#w.close()



#comparing file


c=open('D:/Pdf/Machine Learning/project/E2/compare.txt','w')
dic2=dic
findme=dic[keep]
c.write(keep)
c.write(str(findme))
#print keep
#print findme
del dic2[keep]
for item in sorted(dic2.keys()):
    c.write('\n')
    c.write(item+" " )
    c.write(str(dic2[item]))
    
c.close()


f=open('D:/Pdf/Machine Learning/project/E2/dlt.txt','r')
text1=f.read()
for word in text1.split('\n'):
    if word in dic.keys():
        #print word
        del dic[word]    
f.close()

c=open('D:/Pdf/Machine Learning/project/E2/PD_dic.txt','w')

for item in sorted(dic.keys()):
    c.write('\n')
    c.write(item)
    
c.close()


print "I closed the file"































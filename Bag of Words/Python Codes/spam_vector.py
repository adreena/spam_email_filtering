import sys


#------------------------------------------------------------------------
# uploading the dicitonary file 
#------------------------------------------------------------------------


# emptying the result file (spams)
file2=open('D:/Pdf/Machine Learning/project/train/result.txt','w')
file2.close();

#------------------------------------------------------------------------
#opening the email file and generating the dictionary vector of that email
#------------------------------------------------------------------------
file1=open('D:/Pdf/Machine Learning/project/train/train.txt','r')
spams=file1.read()
file1.close()
for line in spams.split('\n'):
    myfile=open(line,'r')
    text=myfile.read()
    myfile.close()

    #-----------------------------------------
    #  normalizating
    #-----------------------------------------
    def replace_all(text, dic):
        for i, j in dic.iteritems():
            text = text.replace(j, i)
        return text
        
    my_text = text
    reps = {'H':'|-|', 'free':'fr33', 'o':'0', 's':'$','dollars':'dollar$'}
    text = replace_all(my_text, reps)
    list1=['!','?','$',':',";","-",",","/","+","_", "~", "@","%","&","*",'(',')','#','`',"|","{","}",".",">","<","=",'"',"'","[","]"]
    for item in list1:
        for word in text.split(item):
            text=text.replace(item,' ')
    list2=['1','2','3','4','5','6','7','8','9','0']
    for item in list2:
        for word in text.split(item):
            text=text.replace(item,' ')
    text=text.lower()

    #-----------------------------------------
    #checking the word in dictionary
    #-----------------------------------------
    mydic={}
    f=open('D:/Pdf/Machine Learning/project/dictionary/dictionary.txt')
    text1=f.read()
    for line in text1.split('\n'):
        mydic[line]=0
    #print mydic
    f.close()
    for word in text.split():
            if word in mydic:
                mydic[word]+=1
    vector=[]
    main=[]
    for word in sorted(mydic.keys()):
        main.append(word)
    for word in sorted(mydic.keys()):
        vector.append(str(mydic.get(word)))

    #print mydic
    #print '\n' 
    #print main
    #print '\n'
    #print vector
    #print len(mydic)
    x=open('D:/Pdf/Machine Learning/project/train/result.txt','a') # appending
    
    for item in vector:
        x.write(item)
        x.write(" ")
    x.write("\n")
    x.close()


import graphviz as gv

reads = ['ATTCA', 'ATTGA', 'CATTG', 'CTTAT', 'GATTG', 'TATTT', 'TCATT', 'TCTTA', 'TGATT', 'TTATT', 'TTCAT', 'TTCTT', 'TTGAT']
k = 3

kmer_set = set()
edges = open('qb-quant-edges-exercise-2.txt','w')
for i in reads:
    for j in range(len(i)-k):
        e1 = i[j:j+k]
        e2 = i[j+1:j+(k+1)]
        if e1[1:] == e2[:(k-1)]:
            kmer_set.add((e1,e2))
            edges.write(f"{e1} -> {e2}\n")
edges.close()
    
#2.2
"""
Done with with a python script with a conda environment, no command lines were used. See below
"""

#2.3,2.4
"""
See script below. 
"""
dot = gv.Digraph('k-mer-3',comment='3 mer graph for lecture 1 exercise 2')
dot.format = ("png")
for start,end in kmer_set:
    dot.edge(start,end)
dot.render(directory='3mer').replace("\\","/")
from bs4 import BeautifulSoup
import requests
jonathan_space_report  = requests.get("https://planet4589.org/space/jsr/back/")
page = jonathan_space_report.text
links = BeautifulSoup(page)
links_to_not_include = ["?C=N;O=D", "?C=M;O=A", "?C=S;O=A", "?C=D;O=A","/space/jsr/", "a/", "fail", "fastest.html", "mirnews", "n/", "test.html"]
for link in links.find_all('a'):
    if(not (link.get('href') in links_to_not_include)):
        open('C:/Users/Benjamin/Documents/Trinity Documents/Programming Project/Project/Space_report_full/'+ link.get('href'), 'wb').write(requests.get("https://planet4589.org/space/jsr/back/"+link.get('href'), allow_redirects=True).content)


"Table of Recent Launches"
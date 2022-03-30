# Container Web2py	:whale:
Container docker atualizado por mim para rodar o *Web2py 2.22*:clipboard: juntamente com o *Python 3.10*:snake:.   

 :pushpin: Este container combina Web2py e uWSGI em uma imagem única e flexivel, suportando HTTP via WEB2PY e HTTP via UWSGI.

### Como utilizar
 :small_red_triangle_down:Para executar em um HTTP simples digite este comando em seu CMD:
 
    docker run -p 8080:8080 daviga/web2py
    
 Abra este link em qualquer navegador web http://localhost:8080
    
### Como utilizar como administrador
  Para ter acesso de administrador é necessário criar uma key com a sua sessão  
  
  :small_red_triangle:1º Abra o seu CMD na pasta keys do web2py:  
  ![image](https://user-images.githubusercontent.com/86674827/160904285-be49888c-efa3-4eff-89de-2a18a2de30c3.png)  
  
  :small_red_triangle:2º Digite **./create-keys.sh** para criar a key da sua sessão  
  ![image](https://user-images.githubusercontent.com/86674827/160904545-d6728459-3e44-45ea-84db-f6401ce4c1c3.png)  

  :small_red_triangle:3º Digite **cd ..** e após isso digite **docker compose up** para reger o comportamento do web2py com a sua key  
  ![image](https://user-images.githubusercontent.com/86674827/160904977-b73d1165-1204-4339-994a-89a3facc9aba.png)
  
  :white_check_mark:Feito isso você terá acesso ao administrador digitando a SENHA:
  
      1234

  

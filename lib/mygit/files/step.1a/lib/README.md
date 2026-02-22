
# Directorio: **lib**

Usaremos "submódulos" de Git para enlazar las ETL transversales dentro de nuestro proyecto.

## Enlazar con una ETL existente

Procedimiento para enlazar una ETL transversal dentro de nuestro proyecto.
* Localizar URLREPO de la ETL transversal.
* Ejecutar la acción "SUBMODULE ADD"

```
git -C lib submodule add URLREPO
```

* Ahora tenemos ficheros nuevos.

```
> git status

  nuevos archivos: .gitmodules
	nuevos archivos: lib/URLREPO
```

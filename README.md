![](https://github.com/ngdream/H5assembler/blob/ff5bbb7b8fcf68d246994baaf89d75999432f52c/share/gitlogo.png)
# H5 Assembler
its made for all web developer who doesn't like to write the same code  in different file  which his currency : ***``  don't repeat yourself ``***<br/>
you will never need to rewrite the same text again

## state
the H5A repository is on github 
the current version is the 0.1.2

## building
1. ### on window
if you want to build H5assembler on window 
- download msys64
- download mingw64 or  mingw32 toolchains

- download flex , bison and make
in msys64 type
```shell
pacman -S flex
pacman -S bison
pacman -S make
```
-run the make command throw msys shell  in the project directory
``` make```
## exemple of use
h5assembler offers you a technology allowing you to reduce your html code and guarantees you an easy integration in frameworks such as (laravel, django)

**navbar.html**

```html
<nav>
    <a href="">mikle</a>
    <a href="">jordan</a>
    <a href="">taba</a>
</nav>
```
**index.html**
```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
    
    <title>simple include H5assembler</title>
</head>
<body>
@include("navbar.html")

</body>
</html>
```

in in the same directory than index.html run command ``H5A index.html output.html``.
this command will generate an output.html file with the following content
**output.html**

```html
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css">
    
    <title>simple include H5assembler</title>
</head>
<body>
<nav>
    <a href="">mangue</a>
    <a href="">banane</a>
    <a href="">sceau</a>
</nav>

</body>
</html>
```

for more information about h5 using  read the ``documentation``

## contributing
1. you can contribute on github by forking our repository
2. you can donate us by ``paypal`` , by ``orange money`` or by  ``mtn mobile money``
## authors

It is originally developed by Mr. Nguewo fossong christian 

## contributors

help needed : this doesn't have contributors yet .


# documentation 

## content

H5A helps frontend developers write html without repetition
it is also designed so that web designers can create designs that can be easily integrated into frameworks such as (laravel, django and others)

## functions in H5A

h5a have functions  that is started by '@' and  must be included in the file you want to assemble 
### the include function 

this function  is used to include the contents of the file in another 

#### exemble of use * 
if you have these two files in the same directory
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
<span class="fs-1">include page 1</span>
</body>
</html>
```

**navbar.html**

```html
<nav>
    <a href="">mikle</a>
    <a href="">jordan</a>
    <a href="">taba</a>
</nav>
```
launch the terminal in the  same directory and  type ``h5A index.html  output.html``
h5A will generate the following file

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
    <a href="">mikle</a>
    <a href="">jordan</a>
    <a href="">taba</a>
</nav>
<span class="fs-1">include page 1</span>
</body>
</html>
```

### the repeat function 

this function  is used to include the contents of the file in another 

#### exemble of use * 
if you have these two files in the same directory
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
@repeat("3"){
<h5>this is h5 assembler</h5>
}
</body>
</html>
```


launch the terminal in the  same directory and  type ``h5A index.html  output.html``
h5A will generate the following file

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
<h5>this is h5 assembler</h5>
<h5>this is h5 assembler</h5>
<h5>this is h5 assembler</h5>
</body>
</html>
```


## how to use h5 commands


if you type ``h5a {{your file path}} ``
h5a will build your file and the output will be at **output.html**

you can also specify one or  many build paths in h5A
if you type  ``h5a {{your file path}} {{build_path1}} {{build_path2}} {{build_path4}} ..... .... {{build_pathX}}  ``
h5a the build files will be at all specified build paths


## about the h5maker language 

**H5MAKER language is the most owerful functionnality of H5**
by default when you use h5A you can just build one file but with h5maker its possible to build many files  and deploy your  project for every one



## bugs 

**H5 assembler is a new software so it has  some bugs:**

1. stranger strings writed at the end of output file when you build many file by using h5maker language
2. you must specify the output to a folder that exists




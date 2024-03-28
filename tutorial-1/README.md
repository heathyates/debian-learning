## Creating the python application 
```
#!/usr/bin/python3 python
print("hello 1.0.0")
```

## packageroot 
Inside of `tutorial-1` create `packageroot/DEBIAN`. Create `control` as specified in this project. 


## Turning the package root directory into a package  
This step turns package root directory into a package 
```
mkdir -p packageroot/usr/bin
cp hello packageroot/usr/bin
```

We should have the following: 
```
.
|-- README.md
|-- hello
|-- hello_1.0.0_all.deb
`-- packageroot
    |-- DEBIAN
    |   `-- control
    `-- usr
        `-- bin
            `-- hello
```

## Create the package root directory is finished, we turned into a .deb file 
```
dpkg-deb -b packageroot hello_1.0.0_all.deb
```

## Validating the debian package 
If successful, you should see something called `hello_1.0.0_all.deb`. You can validate it as follows: 
```
sudo gdebi -n ./hello_1.0.0_all.deb
```

## Inspecting the .deb file 
```
sudo apt install mc
mc 
```

## Reference 
This has been ported directly from the following below

- [Tutorial 1 by Hongli](https://github.com/FooBarWidget/debian-packaging-for-the-modern-developer/tree/master/tutorial-1)
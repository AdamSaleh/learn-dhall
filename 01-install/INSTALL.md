# Let's install Dhall (by which I mean dhall-yaml)

## Prerequisites:

These instructions have been tested on

* Fedora 31 x86_64

It should work on any distribution of linux as the binaries we use are statically compiled.

Download these files, untar-them and put them in your $PATH:

```
mkdir /tmp/dhall-install
cd /tmp/dhall-install
wget https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-1.29.0-x86_64-linux.tar.bz2
wget https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-bash-1.0.27-x86_64-linux.tar.bz2
wget https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-json-1.6.1-x86_64-linux.tar.bz2
wget https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-lsp-server-1.0.4-x86_64-linux.tar.bz2
wget https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-yaml-1.0.1-x86_64-linux.tar.bz2
for a in $(ls -1 *.tar.bz2); do tar -xvjf $a; done
mkdir -p ~/.local/bin
cp bin/* ~/.local/bin
```

## Test  the installation

First, lets check the our test-data:
```
dhall hash --file 01-test-data/clients.dhall 

Use "dhall --explain" for detailed errors

Error: List elements should all have the same type

{ + age : …
, …
}

3│       { name = "Warren", balance = +100000000,  age = Some 90 }
4│     

01-test-data/clients.dhall:3:7
```

The little diff at the beginning means there seems to be extra `age` field on one of the records.
Lets remove it and run the command again.

```
dhall hash --file 01-test-data/clients.dhall 
```
should result in
```
sha256:be6cb1f43e2461b8127a05b46f308df1bee8a148c154873e7b3b364519cda8d0
```

Last, but not least, lets convert this to yaml:
```
dhall-to-yaml --file 01-test-data/clients.dhall 
```
should result in
```
clients:
- balance: 1
  name: Adam
- balance: 100000000
  name: Warren
```
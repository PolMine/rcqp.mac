---
title: "Preparing the rcqp.mac package"
output: html_document
---

## Purpose

The package is a fork of the 'rcqp' package authored by Bernard Desgraupes
and Sylvain Loiseau. See the plain text README file in this folder for 
further information. 

The original rcqp package has been modified slightly to make the installation
on a Mac OSX system as easy as possible.

## Installation

The package can be installed directly from GitHub using devtools.

```{r}
install.packages("devtools") # if not yet available
devtools::install_github("PolMine/rcqp.mac")
```
Alternatively, a pre-built binary is available via the server of the PolMine
Project.

```{r}
install.packages("rcqp", repos = "http://polmine.sowi.uni-due.de/packages", type = "mac.binary")
```

## Documentation of Modifications

The package is derived from the 'rcqp' package through a set of (minimal)
modifications. Preparing this package requires a system that has the compiled
libraries (libintl, libglib etc.) present.

To following shell commands are executed in the directory where the rcqp.mac
has been created.

```{sh}
wget https://cran.r-project.org/src/contrib/rcqp_0.4.tar.gz
tar xzfv rcqp_0.4.tar.gz
rm rcqp_0.4.tar.gz
mv rcqp/* .
rm -r rcqp
rm -r src # the C source code is not needed
rm configure*
rm cleanup
rm MD5
```

The dependant libraries are copied into a inst/libs directory. To identify 
where the libraries reside, use 'locate'.

```{sh}
mkdir inst/libs
cp /usr/local/lib/libglib-2.0.0.dylib inst/libs
cp /usr/lib/libiconv.2.dylib inst/libs
cp /usr/local/Cellar/gettext/0.19.8.1/lib/libintl.8.dylib inst/libs
sudo cp /usr/local/lib/libpcre.1.dylib inst/libs
cp /Library/Frameworks/R.framework/Versions/3.4/Resources/library/rcqp/libs/rcqp.so inst/libs
chmod 0755 inst/libs/*
```

Go into the R directory, edit the file zzz.R and ensure that the .onLoad
function is defined as follows:

```{r}
.onLoad <-function (lib, pkg) {
  library.dynam("libiconv.2", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libintl.8", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libglib-2.0.0", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libpcre.1", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("rcqp", package = pkg, lib.loc = lib, file.ext = ".so")
}
```

To check whether the package can be built and installed.

```{sh}
cd ..
R CMD build rcqp.mac
R CMD INSTALL rcqp_0.4.tar.gz
```

Building and checking the polmineR package may provide a check that the 
new package works.

```{r}
R CMD INSTALL --build rcqp.mac
```

## Feedback

Your feedback is highly welcome! Please write to Andreas Blaette (andreas.blaette@uni-due.de)

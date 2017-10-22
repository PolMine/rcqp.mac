# ===========================================================================
# File: "zzz.R"
#                        Created: 2011-11-25 13:54:54
#              Last modification: 2011-11-25 13:54:54
# Authors: Bernard Desgraupes <bernard.desgraupes@u-paris10.fr>
#          Sylvain Loiseau <sylvain.loiseau@univ-paris13.fr>
# ===========================================================================

.onLoad <-function (lib, pkg) {
  library.dynam("libiconv.2", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libintl.8", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libglib-2.0.0", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("libpcre.1", package = pkg, lib.loc = lib, file.ext = ".dylib")
  library.dynam("rcqp", package = pkg, lib.loc = lib, file.ext = ".so")
}

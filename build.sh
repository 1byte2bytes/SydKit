export ISL_VERSION=0.18
export GMP_VERSION=6.1.2
export MPFR_VERSION=3.1.5
export MPC_VERSION=1.0.3
export BINUTILS_VERSION=2.27
export GCC_VERSION=6.3.0

export PROJECT_ROOT=$PWD

#===========================
#CLEANUP
#===========================
rm -rf isl*
rm -rf gmp*
rm -rf mpfr*
rm -rf mpc*
rm -rf binutils*
rm -rf gcc*

#===========================
#ISL
#===========================
curl http://isl.gforge.inria.fr/isl-$ISL_VERSION.tar.gz > isl.tar.gz
tar xf isl.tar.gz
mkdir isl-build
cd isl-build
../isl-$ISL_VERSION/configure --prefix=/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install

#===========================
#GMP
#===========================
curl https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.bz2 > gmp.tar.bz2
tar xf gmp.tar.bz2
mkdir gmp-build
cd gmp-build
../gmp-$GMP_VERSION/configure --prefix=/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install

#===========================
#MPFR
#===========================
curl https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.gz > mpfr.tar.gz
tar xf mfpr.tar.gz
mkdir mpfr-build
cd mpfr-build
../mpfr-$MPFR_VERSION/configure --prefix=/SydKit.framework --with-gmp=$PROJECT_ROOT/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install

#===========================
#MPC
#===========================
curl https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz > mpc.tar.gz
tar xf mpc.tar.gz
mkdir mpc-build
cd mpc-build
../mpc-$MPC_VERSION/configure --prefix=/SydKit.framework --with-gmp=$PROJECT_ROOT/SydKit.framework --with-mpfr=$PROJECT_ROOT/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install

#===========================
#BINUTILS
#===========================
curl https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz > binutils.tar.gz
tar xf binutils.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-$BINUTILS_VERSION/configure --with-sysroot --prefix=/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install

#===========================
#GCC
#===========================
curl https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz > gcc.tar.gz
tar xf gcc.tar.gz
mkdir gcc-build
cd gcc-build
../gcc-$GCC_VERSION/configure --with-sysroot --prefix=/SydKit.framework --with-gmp=$PROJECT_ROOT/SydKit.framework --with-mpfr=$PROJECT_ROOT/SydKit.framework --with-mpc=$PROJECT_ROOT/SydKit.framework --with-isl=$PROJECT_ROOT/SydKit.framework
make
make DESTDIR=$PROJECT_ROOT/SydKit.framework install


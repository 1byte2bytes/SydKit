export ISL_VERSION=0.18
export GMP_VERSION=6.1.2
export CLOOG_VERSION=0.18.4
export MPFR_VERSION=3.1.5
export MPC_VERSION=1.0.3
export BINUTILS_VERSION=2.27
export GCC_VERSION=6.2.0

export PROJECT_ROOT=$PWD
export INSTALL_DIR=$HOME/SydKit.framework

#===========================
#CLEANUP
#===========================
rm -rf isl*
rm -rf gmp*
rm -rf mpfr*
rm -rf mpc*
rm -rf binutils*
rm -rf gcc*
rm -rf cloog*

#===========================
#GMP
#===========================
curl https://ftp.gnu.org/gnu/gmp/gmp-$GMP_VERSION.tar.bz2 > gmp.tar.bz2
tar xf gmp.tar.bz2
mv gmp-$GMP_VERSION gmp
#===========================
#CLOOG
#===========================
curl http://www.bastoul.net/cloog/pages/download/cloog-$CLOOG_VERSION.tar.gz > cloog.tar.gz
tar xf cloog.tar.gz
mv cloog-$CLOOG_VERSION cloog
#===========================
#ISL
#===========================
curl http://isl.gforge.inria.fr/isl-$ISL_VERSION.tar.gz > isl.tar.gz
tar xf isl.tar.gz
mv isl-$ISL_VERSION isl
#===========================
#MPFR
#===========================
curl https://ftp.gnu.org/gnu/mpfr/mpfr-$MPFR_VERSION.tar.gz > mpfr.tar.gz
tar xf mpfr.tar.gz
mv mpfr-$MPFR_VERSION mpfr
#===========================
#MPC
#===========================
curl https://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz > mpc.tar.gz
tar xf mpc.tar.gz
mv mpc-$MPC_VERSION mpc
#===========================
#BINUTILS
#===========================
curl https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz > binutils.tar.gz
tar xf binutils.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-$BINUTILS_VERSION/configure --prefix=$INSTALL_DIR
make $MAKE_ARGS
make install

cd ..
#===========================
#GCC
#===========================
curl https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz > gcc.tar.gz
tar xf gcc.tar.gz
mv gmp gcc-$GCC_VERSION
mv cloog gcc-$GCC_VERSION
mv isl gcc-$GCC_VERSION
mv mpfr gcc-$GCC_VERSION
mv mpc gcc-$GCC_VERSION
mkdir gcc-build
cd gcc-build
../gcc-$GCC_VERSION/configure --prefix=$INSTALL_DIR \
    --enable-languages=c,c++ --with-build-config=bootstrap-debug
make bootstrap $MAKE_ARGS
make install


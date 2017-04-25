export GETTEXT_VERSION=0.19.8.1
export LIBICONV_VERSION=1.14
export BINUTILS_VERSION=2.27
export ISL_VERSION=0.18
export GMP_VERSION=6.1.2
export CLOOG_VERSION=0.18.4
export MPFR_VERSION=3.1.5
export MPC_VERSION=1.0.3
export GCC_VERSION=6.3.0

export CMAKE_FOLDER=3.7
export CMAKE_VERSION=3.7.2
export LLVM_VERSION=4.0.0

export PROJECT_ROOT=$PWD
#This is where the final product is going to be installed
export INSTALL_DIR=$HOME/SydKit
#The temporary place to store the toolchains, useful for packaging
export DEST_DIR=$HOME/SydKit

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
rm -rf gettext*
rm -rf libiconv*
rm -rf cmake*
rm -rf zlib*
rm -rf llvm*
rm -rf *.tar.gz
rm -rf *.tar.xz

set -e
export PATH=$DEST_DIR/opt/SydKit/bin:$PATH

#===========================
#CMAKE
#===========================
curl https://cmake.org/files/v$CMAKE_FOLDER/cmake-$CMAKE_VERSION.tar.gz > cmake.tar.gz
tar xf cmake.tar.gz
mkdir cmake-build
cd cmake-build
../cmake-$CMAKE_VERSION/configure --prefix=$INSTALL_DIR
make $MAKE_ARGS
make install

cd ..
#===========================
#LLVM
#===========================
curl http://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz > llvm.tar.xz
curl http://releases.llvm.org/$LLVM_VERSION/cfe-$LLVM_VERSION.src.tar.xz > cfe.tar.xz
curl http://releases.llvm.org/$LLVM_VERSION/clang-tools-extra-$LLVM_VERSION.src.tar.xz > clang-tools-extra.tar.xz
curl http://releases.llvm.org/$LLVM_VERSION/compiler-rt-$LLVM_VERSION.src.tar.xz > compiler-rt.tar.xz
curl http://releases.llvm.org/$LLVM_VERSION/libcxx-$LLVM_VERSION.src.tar.xz > libcxx.tar.xz
tar xf llvm.tar.xz
tar xf cfe.tar.xz
tar xf clang-tools-extra.tar.xz
tar xf compiler-rt.tar.xz
tar xf libcxx.tar.xz
mv llvm-$LLVM_VERSION.src llvm
mv cfe-$LLVM_VERSION.src clang
mv clang-tools-extra-$LLVM_VERSION.src extra
mv compiler-rt-$LLVM_VERSION.src compiler-rt
mv libcxx-$LLVM_VERSION.src libcxx
mv clang llvm/tools
mv extra llvm/tools/clang/tools
mv compiler-rt llvm/projects
mv libcxx llvm/projects
mkdir llvm-build
cd llvm-build
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX:PATH=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release ../llvm
make $MAKE_ARGS
make DESTDIR=$DEST_DIR install

cd ../..
#===========================
#GETTEXT
#===========================
curl https://ftp.gnu.org/gnu/gettext/gettext-$GETTEXT_VERSION.tar.gz > gettext.tar.gz
tar xf gettext.tar.gz
mv gettext-$GETTEXT_VERSION gettext
#===========================
#LIBICONV
#===========================
curl https://ftp.gnu.org/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz > libiconv.tar.gz
tar xf libiconv.tar.gz
mv libiconv-$LIBICONV_VERSION libiconv
#===========================
#BINUTILS
#===========================
curl https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz > binutils.tar.gz
tar xf binutils.tar.gz
mv gettext binutils-$BINUTILS_VERSION
mv libiconv binutils-$BINUTILS_VERSION
mkdir binutils-build
cd binutils-build
../binutils-$BINUTILS_VERSION/configure --target=i686-elf --prefix=$INSTALL_DIR --with-sysroot --disable-nls --disable-werror
make $MAKE_ARGS
make install

cd ..

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
../gcc-$GCC_VERSION/configure --target=i686-elf --prefix=$INSTALL_DIR --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc $MAKE_ARGS
make all-target-libgcc $MAKE_ARGS
make install-gcc
make install-target-libgcc

cd ..

#===========================
#QEMU M68K
#===========================
#git clone --depth=1 -b m68k-dev https://github.com/vivier/qemu-m68k.git
#cd qemu-m68k
#git submodule update --recursive --init
#./configure --prefix=$INSTALL_DIR/m68k
#make
#make install

#===========================
#CREATE PACKAGE
#===========================
cd $DEST_DIR
zip -r opt

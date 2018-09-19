# Author: carlostimoshenkorodrigueslopes@gmail.com

## Install all necessary libraries:
yum install check pam pam-devel freetype libpng libjpeg zlib luajit luajit-devel dbus dbus-devel \
libXcursor libXcursor-devel libXrender libXrender-devel libXrandr libXrandr-devel \
libXfixes libXfixes-devel libxdamage libxdamage-devel libXcomposite libXcomposite-devel \
libXScrnSaver libXScrnSaver-devel libXp libXp-devel libXext libXext-devel libXinerama libXinerama-devel \
libxkbfile libxkbfile-devel libXtst libXtst-devel libxcb libxcb-devel xcb* pulseaudio-libs pulseaudio-libs-devel \
libsndfile libsndfile-devel systemd systemd-devel libblkid libblkid-devel libmount libmount-devel gstreamer1 gstreamer1-devel \
libtiff libtiff-devel giflib giflib-devel mesa-libGL mesa-libGL-devel libspectre libspectre-devel poppler poppler-devel \
librsvg2 librsvg2-devel LibRaw LibRaw-devel xine-lib xine-lib-devel bullet bullet-devel libwebp libwebp-devel fribidi fribidi-devel \
libpeas libpeas-devel vlc vlc-devel

# Flag for duilding:
export CFLAGS="-O3 -ffast-math -march=native"

wget -c "https://download.enlightenment.org/rel/libs/efl/efl-1.20.7.tar.xz" && tar -xf efl-1.20.7.tar.xz
cd efl-1.20.7/
 ./configure --prefix=/usr --enable-systemd
make && sudo make install && sudo ldconfig && cd ..

wget -c "https://download.enlightenment.org/rel/apps/enlightenment/enlightenment-0.22.3.tar.xz"  && tar -xf enlightenment-0.22.3.tar.xz
cd enlightenment-0.22.3/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..


wget -c "https://download.enlightenment.org/rel/apps/terminology/terminology-1.2.0.tar.xz"  && tar -xf terminology-1.2.0.tar.xz
cd terminology-1.2.0/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..

wget -c "https://download.enlightenment.org/rel/apps/rage/rage-0.3.0.tar.xz"  && tar -xf rage-0.3.0.tar.xz
cd rage-0.3.0/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..


wget -c "https://download.enlightenment.org/rel/apps/econnman/econnman-1.1.tar.xz"  && tar -xf econnman-1.1.tar.xz
cd econnman-1.1/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..


wget -c "https://download.enlightenment.org/rel/apps/ephoto/ephoto-1.5.tar.xz"  && tar -xf ephoto-1.5.tar.xz
cd ephoto-1.5/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..


wget -c "https://download.enlightenment.org/rel/apps/epour/epour-0.6.0.tar.xz"  && tar -xf epour-0.6.0.tar.xz
cd epour-0.6.0/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..


wget -c "https://download.enlightenment.org/rel/apps/extra/extra-0.0.1.tar.xz"  && tar -xf extra-0.0.1.tar.xz
cd extra-0.0.1/
 ./configure --prefix=/usr
make && sudo make install && sudo ldconfig && cd ..



rm -rvf efl-1.20.7*
rm -rvf enlightenment-0.22.3*
rm -rvf terminology-1.2.0*
rm -rvf rage-0.3.0*
rm -rvf econnman-1.1*
rm -rvf ephoto-1.5*
rm -rvf epour-0.6.0*
rm -rvf extra-0.0.1*

echo "End."

echo "Trying..."
terminology

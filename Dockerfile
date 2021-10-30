FROM archlinux as hipsycl
RUN useradd user
WORKDIR /home/user

RUN pacman -Sy
RUN pacman -S --noconfirm pacman clang llvm git cuda cmake boost --cachedir /tmp && pacman -Scc --noconfirm

ADD PKGBUILD /home/user/
RUN chown -R user /home/user

USER user
RUN makepkg -s

USER root
RUN pacman --noconfirm -U hipsycl-*
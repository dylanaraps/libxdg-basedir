PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib
INCDIR ?= $(PREFIX)/include
CC     ?= cc
AR     ?= ar

all: libxdg-basedir

libxdg-basedir:
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o libxdg-basedir.o  basedir.c
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o libxdg-basedir.so basedir.c
	$(AR) rcs libxdg-basedir.a 	libxdg-basedir.o

install: all
	install -Dm644 libxdg-basedir.so $(DESTDIR)$(LIBDIR)/libxdg-basedir.so
	install -Dm644 libxdg-basedir.a $(DESTDIR)$(LIBDIR)/libxdg-basedir.a
	ln -s libxdg-basedir.so $(DESTDIR)$(LIBDIR)/libxdg-basedir.so.1
	ln -s libxdg-basedir.so $(DESTDIR)$(LIBDIR)/libxdg-basedir.so.1.2.0
	install -Dm644 pkgconfig $(DESTDIR)$(LIBDIR)/pkgconfig/libxdg-basedir.pc
	install -Dm644 include/basedir.h $(DESTDIR)$(INCDIR)/basedir.h
	install -Dm644 include/basedir_fs.h $(DESTDIR)$(INCDIR)/basedir_fs.h

uninstall:
	rm -f $(DESTDIR)$(LIBDIR)/libxdg-basedir.so
	rm -f $(DESTDIR)$(LIBDIR)/libxdg-basedir.a
	rm -f $(DESTDIR)$(LIBDIR)/libxdg-basedir.so.1
	rm -f $(DESTDIR)$(LIBDIR)/libxdg-basedir.so.1.2.0
	rm -f $(DESTDIR)$(LIBDIR)/pkgconfig/libxdg-basedir.pc
	rm -f $(DESTDIR)$(INCDIR)/basedir.h
	rm -f $(DESTDIR)$(INCDIR)/basedir_fs.h

clean:
	rm -f *.so *.a *.o

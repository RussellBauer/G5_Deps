%define   _topdir    /usr/src/redhat
%define debug_package %{nil}
Name:     protobuf
Version:  2.3.0
Release:  9
License:  Dell Inc.
Packager: Dell Inc.
Summary:  Protocol Buffers are a way of encoding structured data in an efficient format.
Group:    Application/System
Source:   %{name}-%{version}.tar.gz
Url:      http://code.google.com/p/protobuf/
Autoreq:  no
BuildRoot: %{_tmppath}/%{name}-%{version}}-%{release}-root


%description
Protocol Buffers are a way of encoding structured data in an efficient format.
%prep
#echo "prep"
%preun
#echo "preun"
#%setup -c
#echo "setup"
%build
%install
echo "make install"
test -d $RPM_BUILD_ROOT/ && rm -rf  $RPM_BUILD_ROOT/
mkdir -p $RPM_BUILD_ROOT/usr/lib
cd %{name}-%{version}/usr/lib
cp -rf * $RPM_BUILD_ROOT/usr/lib/
%clean
%post
%postun
%files
/usr/lib/libproto*
/usr/lib/pkgconfig/*

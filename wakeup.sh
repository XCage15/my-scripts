#!/bin/bash 
#Required wakeonlan package

#Wake NAS Up
wakeonlan 00:1b:78:58:1f:78

sleep 300

#Wake Xen5 (Pool master ) up
wakeonlan 00:25:90:7e:63:b0

#Wake ESXi1 up
wakeonlan 00:25:90:7e:64:1c

#Wake ESXi2 up
wakeonlan 00:25:90:7e:64:7e

#Wake Xen1 up
wakeonlan 00:25:90:7e:63:ae

#Wake Xen2 up
wakeonlan 00:25:90:7e:63:ba

#Wake Xen3 up
wakeonlan 00:25:90:7e:63:b4

#Wake Xen4 up
wakeonlan 00:25:90:7e:63:b6
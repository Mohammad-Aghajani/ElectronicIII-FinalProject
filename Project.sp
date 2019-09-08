Project-ElecIII
*.lib './TSMC_90nm.l' TT
*Amplifier Netlist
.param lmin = .35u
.model nchan nmos (level=1 vt0=0.7 gamma=0.45 phi=0.9 nsub=9e+14 ld=0.08e-6 u0=350 lambda=0.1 tox=9e-9 pb=0.9 cj=0.56e-3 cjsw=0.35e-11 mj=0.45 mjsw=0.2 cgd0=0.4e-9 js=1.0e-8)
.model pchan pmos (level=1 vt0=-0.8 gamma=0.4 phi=0.8 nsub=5e+14 ld=0.09e-6 u0=100 lambda=0.2 tox=9e-9 pb=0.9 cj=0.94e-3 cjsw=0.32e-11 mj=0.5 mjsw=0.3 cgd0=0.3e-9 js=0.5e-8)
M1 3 Vin- 1 dd pchan W='256*lmin' L='lmin' M=10
M2 2 Vin+ 1 dd pchan W='256*lmin' L='lmin' M=10
M3 3 3 0 ss nchan W='256*lmin' L='lmin' M=10
M4 2 2 0 ss nchan W='256*lmin' L='lmin' M=10
M5 Vout 3 0 ss nchan W='128*lmin' L='lmin' M=40
M6 4 2 0 ss nchan W='128*lmin' L='lmin' M=40
M7 Vout 4 dd dd pchan W='128*lmin' L='lmin' M=40
M8 4 4 dd dd pchan W='128*lmin' L='lmin' M=40
Iss dd 1 dc=8u
vdd dd 0 dc=5
vss ss 0 dc=0
*AC simulation
Vinac Vin+ Vin- ac=1
*Vinac1 Vin- 0 ac=1
.ac dec 10 100 10G
.option  acout=0
*.measure   ac  gain           find  vdb(Vout, 0) at=200
*.probe
.tf V(Vout) Vinac
.op
.PZ V(Vout) Vinac
.four 10M V(Vout)
.end
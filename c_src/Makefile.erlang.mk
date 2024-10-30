ERL_CFLAGS ?= -finline-functions -Wall -fPIC -I "/usr/local/otp-24/erts-12.3.2.17/include" -I "/usr/local/otp-24/lib/erl_interface-5.2.2.1/include"
ERL_LDFLAGS ?= -L "/usr/local/otp-24/lib/erl_interface-5.2.2.1/lib" -lei


all:: priv/syslog_drv.so

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.C
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cc
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

%.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(ERL_CFLAGS) $(DRV_CFLAGS) $(EXE_CFLAGS)

priv/syslog_drv.so: $(foreach ext,.c .C .cc .cpp,$(patsubst %$(ext),%.o,$(filter %$(ext),$(wildcard c_src/*.c))))
	$(CC) -o $@ $? $(LDFLAGS) $(ERL_LDFLAGS) $(DRV_LDFLAGS) $(EXE_LDFLAGS) -shared

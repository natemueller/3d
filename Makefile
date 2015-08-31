OPENSCAD=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
CURA=/Applications/Cura/Cura.app/Contents/MacOS/Cura

TARGETS=$(patsubst %.scad,%.gcode,$(wildcard *.scad))

ifeq (,$(wildcard profile.ini))
	PROFILE=pla_normal
	PROFILE_FILE=/Applications/Cura/Cura.app/Contents/Resources/quickprint/lulzbot_TAZ_5_05nozzle/extra/$(PROFILE).ini
else
	PROFILE_FILE=profile.ini
endif

default: $(TARGETS)

%.gcode: %.stl $(PROFILE_FILE)
	$(CURA) -s -o $(abspath $@) -i $(PROFILE_FILE) $(abspath $<)

%.stl: %.scad
	$(OPENSCAD) -m make -o $@ -d .$@.deps $<

clean:
	rm -f *.stl *.gcode .*.deps

.PRECIOUS: $(patsubst %.scad,%.stl,$(wildcard *.scad))

include $(wildcard .*.deps)

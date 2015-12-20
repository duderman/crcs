require 'mkmf'

$defs << "-DHAVE_CONFIG_H"
$INCFLAGS << " -I$(srcdir)/.. -I$(hdrdir)/ruby"

$objs = [ "crc32.#{$OBJEXT}" ]

have_header('inttypes.h')
have_header('ruby/digest.h')

create_makefile('digest/crc32')

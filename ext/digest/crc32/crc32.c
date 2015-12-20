#include "digest.h"
#include "crc32.h"

static const rb_digest_metadata_t crc32 = {
    RUBY_DIGEST_API_VERSION,
    CRC32_DIGEST_LENGTH,
    CRC32_BLOCK_LENGTH,
    sizeof(CRC32_CTX),
    (rb_digest_hash_init_func_t)CRC32_Init,
    (rb_digest_hash_update_func_t)CRC32_Update,
    (rb_digest_hash_finish_func_t)CRC32_Finish,
};

static unsigned long crc_table[256];

static void crc32_init(void)
{
  unsigned long crc, poly;
  int i, j;

  poly = 0xEDB88320L;
  for (i = 0; i < 256; i++)
    {
      crc = i;
      for (j = 8; j > 0; j--)
	{
	  if (crc & 1)
	    crc = (crc >> 1) ^ poly;
	  else
	    crc >>= 1;
	}
      crc_table[i] = crc;
    }
}

int
CRC32_Init(CRC32_CTX *pms)
{
    pms->count[0] = pms->count[1] = 0;
    pms->state[0] = 0xFFFFFFFF;

    return 1;
}

void
CRC32_Update(CRC32_CTX *pms, const uint8_t *data, size_t nbytes)
{
    register uint32_t crc = pms->state[0];
    register const uint8_t *p = data;
    uint32_t nbits = (uint32_t)(nbytes << 3);

    if (nbytes <= 0)
      return;

    /* Update the message length. */
    pms->count[1] += nbytes >> 29;
    pms->count[0] += nbits;
    if (pms->count[0] < nbits)
      pms->count[1]++;

    /* Update */
    while (nbytes-- > 0)
      crc = ((crc>>8) & 0x00FFFFFF) ^ crc_table[ (crc^(*p++)) & 0xFF ];

    pms->state[0] = crc;
}

int
CRC32_Finish(CRC32_CTX *pms, uint8_t *digest)
{
  register uint32_t crc = pms->state[0] ^ 0xFFFFFFFF;
  register int i;

  for (i = 3; i >= 0; i--)
    {
      digest[i] = (uint8_t)(crc & 0xFF);
      crc = crc >> 8;
    }

  return 1;
}

void
Init_crc32(void)
{
    VALUE mDigest, cDigest_Base, cDigest_CRC32;

    crc32_init();

    rb_require("digest.so");

    mDigest = rb_path2class("Digest");
    cDigest_Base = rb_path2class("Digest::Base");

    cDigest_CRC32 = rb_define_class_under(mDigest, "CRC32", cDigest_Base);

    rb_cvar_set(cDigest_CRC32, rb_intern("metadata"),
        Data_Wrap_Struct(rb_cObject, 0, 0, &crc32));
}



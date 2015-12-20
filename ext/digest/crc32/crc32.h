#ifndef CRC32_INCLUDED
#  define CRC32_INCLUDED

#include "defs.h"

typedef struct crc32_state_s {
    uint32_t count[2];	/* message length in bits, lsw first */
    uint32_t state[1];	/* digest buffer */
} CRC32_CTX;

#ifdef RUBY
#define CRC32_Init	rb_Digest_CRC32_Init
#define CRC32_Update	rb_Digest_CRC32_Update
#define CRC32_Finish	rb_Digest_CRC32_Finish
#endif

int	CRC32_Init _((CRC32_CTX *pms));
void CRC32_Update _((CRC32_CTX *pms, const uint8_t *data, size_t nbytes));
int	CRC32_Finish _((CRC32_CTX *pms, uint8_t *digest));

#define CRC32_BLOCK_LENGTH 64
#define CRC32_DIGEST_LENGTH 4
#define CRC32_DIGEST_STRING_LENGTH	(CRC32_DIGEST_LENGTH * 2 + 1)

#endif /* CRC32_INCLUDED */

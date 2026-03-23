/**
 * \file oqs.h
 * \brief Overall header file for the liboqs public API.
 *
 * C programs using liboqs can include just this one file, and it will include all
 * other necessary headers from liboqs.
 *
 * SPDX-License-Identifier: MIT
 */

#ifndef OQS_H
#define OQS_H

#include <PayUoqs/oqs/oqsconfig.h>

#include <PayUoqs/oqs/common.h>
#include <PayUoqs/oqs/rand.h>
#include <PayUoqs/oqs/kem.h>
#include <PayUoqs/oqs/sig.h>
#include <PayUoqs/oqs/sig_stfl.h>
#include <PayUoqs/oqs/aes_ops.h>
#include <PayUoqs/oqs/sha2_ops.h>
#include <PayUoqs/oqs/sha3_ops.h>
#include <PayUoqs/oqs/sha3x4_ops.h>

#endif // OQS_H

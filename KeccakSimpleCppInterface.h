
#pragma once

#include <string>
#include <vector>
#include <iostream>
using namespace std;

typedef vector<unsigned char> byte_vector;

extern "C" {
#include "KeccakHash.h"
}

/*
 * N defines the number of bits of the output (hash)
 * C defines the capacity, has to be a multiple of 8 and less than 1600 (see below)
 * as the collision probability for an output collision is ~2^{-N/2}, 
 * while the probability for an inner collision is ~2^{-C/2}, 
 * it makes sense to choose N==C
 * but sometimes you might want to derive more than 1600 bits from an input (e.g. when using Keccak as PRG) 
 * that's when you need to choose N > C
 */
template<unsigned int N,unsigned int C=N>
class KeccakSimpleCppInterface {
public:
	//hashbitlen:
	//just another name for L to make it accessible
	static const unsigned int hashbitlen = N;
	static const unsigned int hashlen = N/8;
	
	//bufferbitlen:
	//internally Keccak uses a buffer storing 1600 bits
	static const unsigned int bufferbitlen = 1600;
	//capacity:
	//number of bits of the buffer which are kept "secret"; 
	static const unsigned int capacity     = C;  
	//rate: 
	//simply the remaining bufferbitlen-capacity bits of the buffer
	//also the number of bits read/output within a single iteration of the sponge construction
	//therefore determines the number of iterations (speed)
	static const unsigned int rate         = bufferbitlen - capacity; 
	//delim:
	//see "KeccakSponge.h" (Keccak_SpongeAbsorbLastFewBits) for (a bit) more details
	//can be used to encode in which mode Keccak (e.g. simply hashing or as PRG or as MAC/PRF) is currently used
	//so that the same input will yield different outputs in different modes
	//we stick to the default
	static const unsigned char delim       = 0x01;
	
private:
	//finalized:
	//remembers whether we have produced the hashvalue already or not
	//if we already have computed the hash value we shouldn't allow to append any data in most hash function constructions (in particular MD)
	bool finalized;
	
	Keccak_HashInstance keccakState; //contains the internal buffer, the rate, the capacity, and some additional information
	
public:
	void restart() {
		finalized = false;
		Keccak_HashInitialize(&keccakState,rate,capacity,hashbitlen,delim);
	}

	KeccakSimpleCppInterface() {
		static_assert(rate % 8 == 0, "rate must be a multiple of 8");
		static_assert(hashbitlen > 0, "hashbitlen must be positive");
		static_assert(capacity < bufferbitlen, "capacity must be less than 1600");
		static_assert(rate < bufferbitlen, "rate must be less than 1600");
		restart();
	}
	
	void update( const unsigned char* data, unsigned int databitlen ) {
		if(finalized) return;
		
		Keccak_HashUpdate(&keccakState,data,databitlen);
	}
	
	void update( const string &msg ) {
		update((const unsigned char*)msg.data(),8*msg.length());
	}
	
	void update( const byte_vector &data) {
		update(data.data(),8*data.size());
	}
	
	void finalize( byte_vector &hash ) {
		if(finalized) return; //better: throw an exception
		finalized = true;
		hash.clear();
		hash.resize(hashlen);
		Keccak_HashFinal(&keccakState,hash.data()); //in c++11 vector<>::data() is not const-only anymore
	}
	
	void simpleHash( byte_vector &hash, const string &msg ) {
		restart();
		update(msg);
		finalize(hash);
	}
	
};


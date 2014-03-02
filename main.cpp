#include "KeccakSimpleCppInterface.h"

/*
 * some data used in the following
 */
const string msg1 = "I will not have my fwends widiculed by the common soldiewy. Anybody else feel like a little... giggle... when I mention my fwiend... Biggus...";
const string msg2 = "Sir Bedevere: 'Now, why do witches burn?' Peasant: '...because they're made of... wood?' Sir Bedevere: 'Good. So how do you tell whether she is made of wood?' Peasant 2: 'Build a bridge out of her.'";
const string msg3 = "There shall, in that time, be rumours of things going astray, erm, and there shall be a great confusion as to where things really are, and nobody will really know where lieth those little things... with the sort of raffia work base that has an attachment. At this time, a friend shall lose his friend's hammer and the young shall not know where lieth the things possessed by their fathers that their fathers put there only just the night before, about eight o'clock.";
const string url = "http://en.wikipedia.org/wiki/Monty_Python";

/*
 * some helper functions
 */
void convertToHex( string &hex, const byte_vector bytes ) {
	static const char lookuptable[] = { '0', '1', '2', '3', '4', '5', '6', '7',
		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
	
	hex.clear();
	hex.reserve(2*bytes.size());
	
	for( unsigned int i = 0; i < bytes.size(); ++i ) {
		hex.push_back(lookuptable[bytes[i]>>4]);
		hex.push_back(lookuptable[bytes[i]&0x0F]);
	}
}

void keccakExamplePrettyPrinter( const string &msg, const byte_vector &hash ) {
	string hashInHex;
	convertToHex(hashInHex,hash);
	cout << "Msg:  " << msg << endl;
	cout << "hash: " << hashInHex << endl << endl;
}

template<unsigned int N,unsigned int C=N>
void keccakExample() {
	byte_vector hash;
	
	/*
	 * Some examples how to use the class
	 */
	KeccakSimpleCppInterface<N,C> Keccak;
	
	/*
	 * Examples for directly hashing a string to a hash value
	 */
	Keccak.simpleHash(hash,msg1);
	keccakExamplePrettyPrinter(msg1,hash);
	
	Keccak.simpleHash(hash,msg2);
	keccakExamplePrettyPrinter(msg2,hash);
	
	Keccak.simpleHash(hash,msg3);
	keccakExamplePrettyPrinter(msg3,hash);
	
	/*
	 * Example: Computing a hash value when the data is split up
	 */
	Keccak.restart(); //re-initialize the internal state
	Keccak.update(msg1);
	Keccak.update(msg2);
	Keccak.update(msg3);
	Keccak.finalize(hash);
	keccakExamplePrettyPrinter(msg1+msg2+msg3,hash);
	
	/*
	 * For comparison: this should yield the same hash value
	 */
	Keccak.simpleHash(hash,msg1+msg2+msg3);
	keccakExamplePrettyPrinter(msg1+msg2+msg3,hash);
}

/* 
 * TODO: Read the comments
 */
void nmacExample( byte_vector &mac ) {
	/*
	 * Use a capacity of 576 bits for all the following computations
	 */
	const unsigned int C = 576; //capacity
	const unsigned int R = 1600 - C; //rate
	const unsigned int N = 256; //bit-length of the mac
	
	/*
	 * TODO: derive from msg1 resp. msg2 the key innerKey resp. outerKey key
	 *       using keccak with C bit capacity and R bit hash value
	 *       (yes R bits, not N bits)
	 */
	byte_vector innerKey;
	byte_vector outerKey;
	KeccakSimpleCppInterface<R,C> Keccak;
	Keccak.simpleHash(innerKey, msg1);
	Keccak.simpleHash(outerKey, msg2);
	
	/*
	 * TODO: compute a N bit mac for url using the N/HMAC construction based on
	 *       keccak use innerKey as inner key and outerKey as outer key
	 *       (surprise! ...)
	 * 
	 * Recall that in the NMAC construction the key resides in the first block
	 * read by iterated function in case of Keccak,  this function reads
	 * exactly R=1600-C bits per iteration that's why you hashed msg1 and msg2
	 * to R bit hash values
	 */
	KeccakSimpleCppInterface<N,C> Keccak2;
	Keccak2.restart();
	Keccak2.update(innerKey);
	Keccak2.update(url);
	byte_vector innerResult;
	Keccak2.finalize(innerResult);

	Keccak2.restart();
	Keccak2.update(outerKey);
	Keccak2.update(innerResult);
	Keccak2.finalize(mac);
}

void keccakAsMacExample( byte_vector &mac ) {
	/*
	 * NEW CAPACITY!!!
	 * Use a capacity of 512 bits for all the following computations
	 */
	const unsigned int C = 512; //capacity
	const unsigned int N = 256; //bit-length of the mac
	
	/*
	 * TODO: The authors of Keccak recommend to simply use mac_k(m) := H(k||m)
	 *       as MAC in case of H being Keccak where the key k is read within a
	 *       single iteration again.
	 *
	 * Recall that this is insecure if H is a hash function based directly on
	 * the Merkle-Damgard construction! Use Keccak to derive the key k this
	 * time from msg3. Compute the mac again for url
	 */
	byte_vector key;
	KeccakSimpleCppInterface<1600 - C,C> KeccakKeyer;
	KeccakKeyer.simpleHash(key, msg3);

	KeccakSimpleCppInterface<N,C> Keccak;
	Keccak.restart();
	Keccak.update(key);
	Keccak.update(url);
	Keccak.finalize(mac);
}
 
/*
 * Main function, nothing to do here, except for removing the examples as soon
 * as they start to get on your nerves
 */
int main(int argc, char **argv)
{
	/*
	 * Some examples: 256bit hashes with 256bit capacity 
	 */
	keccakExample<256>();
	
	/*
	 * For comparison: 256bit hashes with 512 capacity
	 */
	keccakExample<256,512>();
	

	/*
	 * Don't delete this
	 */
	byte_vector mac1;
	byte_vector mac2;
	
	nmacExample(mac1);
	keccakAsMacExample(mac2);
	
	if( mac1.size() != 256/8 ) {
		cerr << "Something is wrong: mac1 should consist of 256 bits" << endl;
		return -1;
	}
	if( mac2.size() != 256/8 ) {
		cerr << "Something is wrong: mac2 should consist of 256 bits" << endl;
		return -1;
	}
	
	/*
	 * Combine both macs into a single byte_vector
	 */
	for( unsigned int i = 0; i < 256/8; ++i ) {
		mac1[i] ^= mac2[i];
	}
	
	string newPassword;
	
	convertToHex(newPassword,mac1);
	
	/*
	 * Use this as new password for the slides, pipe it into some text file
	 */
	cout << newPassword << endl;

	return 0;
}

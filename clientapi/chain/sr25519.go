package chain

import (
	"fmt"

	sr25519 "github.com/ChainSafe/go-schnorrkel"
	"github.com/gtank/merlin"
)

const (
	miniSecretKeyLength = 32
	secretKeyLength     = 64
	signatureLength     = 64
)

type SrPubKey struct {
	key *sr25519.PublicKey
}

func (pub SrPubKey) Public() []byte {
	bytes := pub.key.Encode()
	return bytes[:]
}

func (pub SrPubKey) AccountID() []byte {
	return pub.Public()
}

func (pub SrPubKey) SS58Address(network uint16) string {
	return SS58Encode(pub.AccountID(), network)
}

func (pub SrPubKey) Verify(msg []byte, signature []byte) bool {
	var sigs [signatureLength]byte
	copy(sigs[:], signature)
	sig := new(sr25519.Signature)
	if err := sig.Decode(sigs); err != nil {
		return false
	}
	ok, err := pub.key.Verify(sig, signingContext(msg))
	if err != nil || !ok {
		return false
	}

	return true
}

func signingContext(msg []byte) *merlin.Transcript {
	return sr25519.NewSigningContext([]byte("substrate"), msg)
}

func NewSrPubKeyFromSS58Address(address string) (*SrPubKey, error) {
	_, badPubkeyBytes, err := SS58Decode(address)
	if err != nil {
		return nil, err
	}
	return SrFromPublicKey(badPubkeyBytes)
}

func SrFromPublicKey(bytes []byte) (*SrPubKey, error) {
	if len(bytes) != 32 {
		return nil, fmt.Errorf("expected 32 bytes")
	}
	arr := [32]byte{}
	copy(arr[:], bytes[:32])
	key, err := sr25519.NewPublicKey(arr)
	if err != nil {
		return nil, err
	}

	return &SrPubKey{key: key}, nil
}

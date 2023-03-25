package chain

import (
	"crypto/ed25519"
)

type EdPubKey struct {
	key *ed25519.PublicKey
}

func (pub EdPubKey) Verify(msg []byte, signature []byte) bool {
	return ed25519.Verify(*pub.key, msg, signature)
}

func (pub EdPubKey) Public() []byte {
	return *pub.key
}

func (pub EdPubKey) AccountID() []byte {
	return pub.Public()
}

func (pub EdPubKey) SS58Address(network uint16) string {
	return SS58Encode(pub.AccountID(), network)
}

func NewEdPubKeyFromSS58Address(address string) (*EdPubKey, error) {
	_, badPubkeyBytes, err := SS58Decode(address)
	if err != nil {
		return nil, err
	}
	return EdFromPublicKey(badPubkeyBytes)
}

func EdFromPublicKey(bytes []byte) (*EdPubKey, error) {
	key := ed25519.PublicKey(bytes)
	return &EdPubKey{key: &key}, nil
}

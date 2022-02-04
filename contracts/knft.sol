pragma solidity 0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import { Base64 } from "./libraries/Base64.sol";

contract knft is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenId;

  string public collectionName;
  string public collectionSymbol;

  constructor() ERC721("knft", "knft") {
    collectionName = name();
    collectionSymbol = symbol();
  }

  function createknft() public returns(uint256) {
    uint256 newItemId = _tokenId.current();

    string memory baseSvg = "<svg viewBox='0 0 350 350' xmlns='http://www.w3.org/2000/svg' ><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><circle cx='175' cy='175' r='175' width='100%' height='100%' fill='black'></circle><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>Token #";

    string memory finalSvg = string(abi.encodePacked(baseSvg, Strings.toString(newItemId), "</text></svg>"));

    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                '{"name": "',
                    Strings.toString(newItemId),
                    '", "description": "A highly acclaimed collection Warriors", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                '"}'
                )
            )
        )
    );

    string memory finalTokenURI = string(abi.encodePacked(
        "data:application/json;base64,", json
    ));

    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, finalTokenURI);

    _tokenId.increment();

    return newItemId;

    }
}

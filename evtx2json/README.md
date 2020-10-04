# evtx2json
> PowerShell script to read local .evtx files and generate json files.

Use this script to read and generate json with most recent date and time, after that you can ingest data into SIEM to reproduce and test rules.

## Requirements

There are now requirements:

## Installation

There are no installation.

## Usage example

You need to specify two arguments, example:

```sh
.\evtx2json.ps1 -In ".\sample.evtx" -Out ".\sample.json"
```

The result example:

```sh
------------------------------------------------
|    evtx2json - Replay a lot of EVTX!        |
------------------------------------------------
[-] Starting to read EVTX file: .\sample.evtx
[-] Getting date time in UTC format.
[-] Total events: 2
[+] Processing: 1/2 - 50%
[+] Processing: 2/2 - 100%
[-] Write file output: .\sample.json
```

One file will be created:
```sh
sample.json
```

## Development setup

There are no development setup.

## Release History

* 1.0.0
    * The first proper release

## Meta

Rodrigo Ribeiro – [@silvarribeiros](https://twitter.com/silvarribeiros) – silva.rrs@gmail.com

[https://github.com/rodrigorribeiro/](https://github.com/rodrigorribeiro/)

## Contributing

1. Fork it (<https://github.com/rodrigorribeiro/Language-Python/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

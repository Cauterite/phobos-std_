# Usage

Not much to it really

	import std_;
	void main() {
		auto x = JSONValue_([`fdsa` : 10, `ytrewq` : 22]);
		writeln_(toJSON_(&x).retro_().asUpperCase_());
		GC_.collect(); // D-runtime symbols are exposed too
	};

Note: it's not well tested. There could be problems with modules that publicly import other internal modules.

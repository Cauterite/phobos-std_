/* -------------------------------------------------------------------------- */

private struct PkgsØ {

	/* --- runtime --- */

	import core_atomic = core.atomic;

	//import core_attribute = core.attribute;

	import core_bitop = core.bitop;

	import core_checkedint = core.checkedint;

	import core_cpuid = core.cpuid;

	import core_demangle = core.demangle;

	import core_exception = core.exception;

	import core_math = core.math;

	import core_memory = core.memory;

	import core_runtime = core.runtime;

	import core_simd = core.simd;

	import core_sync_barrier = core.sync.barrier;
	import core_sync_condition = core.sync.condition;
	import core_sync_config = core.sync.config;
	import core_sync_exception = core.sync.exception;
	import core_sync_mutex = core.sync.mutex;
	import core_sync_rwmutex = core.sync.rwmutex;
	import core_sync_semaphore = core.sync.semaphore;

	import core_thread = core.thread;

	import core_time = core.time;

	import core_vararg = core.vararg;

	/* --- phobos --- */

	import std_algorithm_comparison = std.algorithm.comparison;
	import std_algorithm_iteration = std.algorithm.iteration;
	import std_algorithm_mutation = std.algorithm.mutation;
	import std_algorithm_setops = std.algorithm.setops;
	import std_algorithm_searching = std.algorithm.searching;
	import std_algorithm_sorting = std.algorithm.sorting;

	import std_array = std.array;

	import std_ascii = std.ascii;

	import std_base64 = std.base64;

	import std_bigint = std.bigint;

	import std_bitmanip = std.bitmanip;

	import std_compiler = std.compiler;

	import std_complex = std.complex;

	import std_concurrency = std.concurrency;

	import std_container_array = std.container.array;
	import std_container_binaryheap = std.container.binaryheap;
	import std_container_dlist = std.container.dlist;
	import std_container_rbtree = std.container.rbtree;
	import std_container_slist = std.container.slist;
	import std_container_util = std.container.util;

	import std_conv = std.conv;

	import std_csv = std.csv;

	import std_datetime = std.datetime;

	import std_demangle = std.demangle;

	import std_digest_crc = std.digest.crc;
	import std_digest_digest = std.digest.digest;
	//import std_digest_hmac = std.digest.hmac;
	import std_digest_md = std.digest.md;
	import std_digest_ripemd = std.digest.ripemd;
	import std_digest_sha = std.digest.sha;

	import std_encoding = std.encoding;

	import std_exception = std.exception;

	// import std.experimental.

	import std_file = std.file;

	import std_format = std.format;

	import std_functional = std.functional;

	import std_getopt = std.getopt;

	import std_json = std.json;

	import std_math = std.math;

	import std_mathspecial = std.mathspecial;

	import std_meta = std.meta;

	import std_mmfile = std.mmfile;

	//import std_net_curl = std.net.curl;
	//import std_net_isemail = std.net.isemail;

	import std_numeric = std.numeric;

	import std_outbuffer = std.outbuffer;

	import std_parallelism = std.parallelism;

	import std_path = std.path;

	import std_process = std.process;

	import std_random = std.random;

	import std_range = std.range;
	import std_range_interfaces = std.range.interfaces;
	import std_range_primitives = std.range.primitives;

	import std_regex = std.regex;

	import std_signals = std.signals;

	import std_socket = std.socket;

	import std_stdint = std.stdint;

	import std_stdio = std.stdio;

	import std_string = std.string;

	import std_system = std.system;

	import std_traits = std.traits;

	import std_typecons = std.typecons;

	import std_uni = std.uni;

	import std_uri = std.uri;

	import std_utf = std.utf;

	import std_uuid = std.uuid;

	import std_variant = std.variant;

	//import std_xml = std.xml;

	//import std_zip = std.zip;

	import std_zlib = std.zlib;
};

private enum translateØ = (string Name) => Name~`_`;

private enum codegenØ = {
	string R;

	foreach (Pkg; __traits(allMembers, PkgsØ)) {
		foreach (Sym; __traits(allMembers, __traits(getMember, PkgsØ, Pkg))) {

			enum Pri = `PkgsØ.`~Pkg~`.`~Sym;
			enum Pub = translateØ(Sym);

			// issues.dlang.org/show_bug.cgi?id=16309
			static if (Sym != `crcHexString` && __traits(compiles, mixin(
				`{static assert(__traits(getProtection, `~Pri~`) == "public");}`
			))) {
				/* define if we can and not already defined */
				R ~= `static if (
					__traits(compiles, {alias X = `~Pri~`;}) &&
					!__traits(compiles, {alias X = `~Pub~`;})
				) {
					public alias `~Pub~` = `~Pri~`;
				};`~'\n';
			};
		};
	};

	return R;
};

mixin(codegenØ());

/* -------------------------------------------------------------------------- */

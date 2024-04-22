import { compileWat, WasmRunner } from "@exercism/wasm-lib";

let wasmModule;
let currentInstance;

beforeAll(async () => {
  try {
    const watPath = new URL("./resistor-color.wat", import.meta.url);
    const { buffer } = await compileWat(watPath);
    wasmModule = await WebAssembly.compile(buffer);
  } catch (err) {
    console.log(`Error compiling *.wat: \n${err}`);
    process.exit(1);
  }
});

function strcmp(lhs = "", rhs = "", length = 0) {
  const inputBufferOffset = 64;
  const lhsBufferOffset = inputBufferOffset;
  const inputBufferCapacity = 128;

  const lhsLengthEncoded = new TextEncoder().encode(lhs).length;
  if (lhsLengthEncoded > inputBufferCapacity) {
    throw new Error(
      `String is too large for buffer of size ${inputBufferCapacity} bytes`
    );
  }

  currentInstance.set_mem_as_utf8(lhsBufferOffset, lhsLengthEncoded, lhs);

  const rhsBufferOffset = lhsBufferOffset + lhsLengthEncoded

  const rhsLengthEncoded = new TextEncoder().encode(rhs).length;
  if (rhsLengthEncoded > inputBufferCapacity) {
    throw new Error(
      `String is too large for buffer of size ${inputBufferCapacity} bytes`
    );
  }

  currentInstance.set_mem_as_utf8(rhsBufferOffset, rhsLengthEncoded, rhs);

  return currentInstance.exports.strcmp(
    lhsBufferOffset,
    rhsBufferOffset,
    length,
  );
}

describe("ResistorColorExtra", () => {
  beforeEach(async () => {
    currentInstance = null;

    if (!wasmModule) {
      return Promise.reject();
    }
    try {
      currentInstance = await new WasmRunner(wasmModule);
      return Promise.resolve();
    } catch (err) {
      console.log(`Error instantiating WebAssembly module: ${err}`);
      return Promise.reject();
    }
  });

  describe("strcmp", () => {
    test("equal", () => {
      expect(strcmp("foo", "foo", 3)).toEqual(0);
    });

    test("empty string", () => {
      expect(strcmp("", "", 0)).toEqual(0);
    });

    test("not equal left side greater", () => {
      expect(strcmp("foo", "bar", 3)).toBeGreaterThan(0);
    });

    test("not equal right side greater", () => {
      expect(strcmp("bar", "foo", 3)).toBeLessThan(0);
    });

    test("not equal right side longer", () => {
      expect(strcmp("bar", "barbazz", 7)).toBeLessThan(0);
    });

    test("equal within length right side longer", () => {
      expect(strcmp("bar", "barbazz", 3)).toEqual(0);
    });

    test("not equal left side longer", () => {
      expect(strcmp("foobar", "foo", 6)).toBeGreaterThan(0);
    });

    test("equal within length left side longer", () => {
      expect(strcmp("foobar", "foo", 3)).toEqual(0);
    });
  });
});

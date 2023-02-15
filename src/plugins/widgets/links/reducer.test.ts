import { addLink, removeLink, updateLink, reorderLink } from "./actions";
import { reducer } from "./reducer";

describe("links/reducer()", () => {
  it("should add new links", () => {
    expect(reducer([], addLink())).toEqual([{ url: "https://" }]);
    expect(
      reducer([{ url: "https://prtl.cc/" }], { type: "ADD_LINK" }),
    ).toEqual([{ url: "https://prtl.cc/" }, { url: "https://" }]);
  });

  it("should remove links", () => {
    expect(
      reducer(
        [
          { url: "https://prtl.cc/" },
          { url: "https://prtl.cc/about.html" },
        ],
        removeLink(0),
      ),
    ).toEqual([{ url: "https://prtl.cc/about.html" }]);
  });

  it("should update links", () => {
    expect(
      reducer(
        [
          { url: "https://prtl.cc/" },
          { url: "https://prtl.cc/about.html" },
        ],
        updateLink(0, { name: "Tabliss", url: "https://prtl.cc/" }),
      ),
    ).toEqual([
      { name: "Tabliss", url: "https://prtl.cc/" },
      { url: "https://prtl.cc/about.html" },
    ]);
  });

  it("should reorder links", () => {
    expect(
      reducer(
        [
          { url: "https://prtl.cc/" },
          { url: "https://prtl.cc/about.html" },
          { url: "https://prtl.cc/support.html" },
        ],
        reorderLink(1, 0),
      ),
    ).toEqual([
      { url: "https://prtl.cc/about.html" },
      { url: "https://prtl.cc/" },
      { url: "https://prtl.cc/support.html" },
    ]);

    expect(
      reducer(
        [
          { url: "https://prtl.cc/" },
          { url: "https://prtl.cc/about.html" },
          { url: "https://prtl.cc/support.html" },
        ],
        reorderLink(1, 2),
      ),
    ).toEqual([
      { url: "https://prtl.cc/" },
      { url: "https://prtl.cc/support.html" },
      { url: "https://prtl.cc/about.html" },
    ]);
  });

  it("should throw on unknown action", () => {
    expect(() => reducer([], { type: "UNKNOWN" } as any)).toThrow();
  });
});

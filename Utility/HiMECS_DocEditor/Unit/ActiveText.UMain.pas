{
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2008-2023, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Provides interfaces, a factory class and implementation of "active text".
 * Active text is text that can have actions performed on it. Actions may
 * include formatting and clickable links.
 *
 * The active text object provides a list of a mixture of text and compound
 * action elements. Text elements contain text to be displayed in the current
 * context. Action elements occur in matched pairs and specify an action to be
 * performed: the first action element switches on the action and the second
 * switches it off. Action elements can either change the display context or
 * define some action to be performed, or both.
 *
 * Active text does not define how it is rendered. It is up to the user to
 * determine how to render the text by examining the elements. Some elements are
 * defined as block level and some as inline, which provides a hint as to how to
 * render.
 *
 * An active text object can be created by interpreting a textual markup
 * language. The object is language agnostic. The user must provide a parser
 * that can interpret the language and create the required active text elements.
}


unit ActiveText.UMain;


interface


uses
  // Delphi
  Generics.Collections,
  // Project
  UBaseObjects, UExceptions;


type
  ///  <summary>Contains constants that name the attributes supported by
  ///  different kinds of active text element.</summary>
  TActiveTextAttrNames = record
  public
    const
      ///  <summary>Name of attribute that stores a link tag's URI.</summary>
      Link_URL = 'href';
  end;

type
  ///  <summary>Indicates whether a active text action element is opening or
  ///  closing.</summary>
  ///  <remarks>An opening action element changes the state of the document
  ///  while a closing element restores the document state to that pertaining
  ///  before the opening element was encountered.</remarks>
  TActiveTextElemState = (
    fsClose,        // element is closing
    fsOpen          // element is opening
  );

type
  ///  <summary>Indicates how an active text action element is displayed.
  ///  </summary>
  TActiveTextDisplayStyle = (
    dsInline,   // element is inline
    dsBlock     // element is block
  );

type
  ///  <summary>
  ///  Base, do nothing, interface supported by all active text elements.
  ///  </summary>
  IActiveTextElem = interface(IInterface)
    ['{F08A9853-EDB6-4B14-8E21-F3AB10FAF7D9}']
  end;

type
  ///  <summary>Interface supported by plain text active text elements.
  ///  </summary>
  ///  <remarks>All instances that support this interface kind Kind = ekText.
  ///  </remarks>
  IActiveTextTextElem = interface(IActiveTextElem)
    ['{B20C56D2-4ACC-48C8-AB30-9979A1B148B3}']
    ///  <summary>Returns plain text represented by element.</summary>
    function GetText: string;
    ///  <summary>Plain text represented by element.</summary>
    property Text: string read GetText;
  end;

type
  ///  <summary>Encapsulates an attribute of a active text action element.
  ///  </summary>
  ///  <remarks>Key field is attribute name and Value field is attribute value.
  ///  </remarks>
  TActiveTextAttr = TPair<string,string>;

type
  ///  <summary>Interface supported by active text attributes.</summary>
  IActiveTextAttrs = interface(IInterface)
    ['{6AE73940-60C4-4097-8DB8-6A88C97D7DA7}']
    ///  <summary>Returns value of named attribute.</summary>
    ///  <remarks>Exception raised if no such attribute exists.</remarks>
    function GetAttr(const Name: string): string;
    ///  <summary>Array property indexed by attribute name and returning
    ///  attribute values.</summary>
    ///  <remarks>Exception raised if no such attribute exists.</remarks>
    property Attrs[const Name: string]: string read GetAttr; default;
    ///  <summary>Returns number of attributes.</summary>
    function Count: Integer;
    ///  <summary>Records the value of a named attribute.</summary>
    procedure Add(const Name, Value: string);
    ///  <summary>Returns a new attribute enumerator.</summary>
    ///  <remarks>Caller is responsible for freeing the enumerator.</remarks>
    function GetEnumerator: TEnumerator<TActiveTextAttr>;
  end;

type
  ///  <summary>Supported types of active text action elements.</summary>
  TActiveTextActionElemKind = (
    ekLink,           // link element: has a URL (inline)
    ekStrong,         // text formatted as strong (inline)
    ekEm,             // text formatted as emphasised (inline)
    ekVar,            // text formatted as variable (inline)
    ekPara,           // delimits a paragraph (block)
    ekWarning,        // text formatted as a warning (inline)
    ekHeading,        // delimits a heading (block level)
    ekMono,           // text formatted as mono spaced (inline)
    ekUnorderedList,  // container for unordered lists (block)
    ekOrderedList,    // container for ordered list (block)
    ekListItem,       // list item (block)
    ekBlock,          // container for unexpected text outside block (block)
    ekDocument        // contains whole document (block)
  );

type
  ///  <summary>Set of types of active text action elements.</summary>
  TActiveTextActionElemKinds = set of TActiveTextActionElemKind;

type
  ///  <summary>Interface supported by active text action elements, i.e. those
  ///  that specify actions to be performed on text.</summary>
  ///  <remarks>Actions include formatting text and hot links.</remarks>
  IActiveTextActionElem = interface(IActiveTextElem)
    ['{2956A28F-AED2-437E-A405-9A62077BD881}']
    ///  <summary>Returns kind of action represented by this element.</summary>
    function GetKind: TActiveTextActionElemKind;
    ///  <summary>Kind of action represented by this element.</summary>
    property Kind: TActiveTextActionElemKind read GetKind;
    ///  <summary>Gets state of element. Informs whether this element is an
    ///  opening or closing element.</summary>
    ///  <remarks>Opening elements switch on the action and closing elements
    ///  switch off the action.</remarks>
    function GetState: TActiveTextElemState;
    ///  <summary>Indicates whether element is opening or closing operation.
    ///  </summary>
    ///  <remarks>Operation is determined by inherited Kind property.</remarks>
    property State: TActiveTextElemState read GetState;
    ///  <summary>Returns object describing element's attributes.</summary>
    function GetAttrs: IActiveTextAttrs;
    ///  <summary>Object describing element's attributes.</summary>
    property Attrs: IActiveTextAttrs read GetAttrs;
  end;

type
  ///  <summary>Interface that defines operations of active text objects.
  ///  </summary>
  IActiveText = interface(IInterface)
    ['{230228FB-355F-4EC9-9EA9-F8A6DE628972}']
    ///  <summary>Gets enumerator for active text object's elements.</summary>
    function GetEnumerator: TEnumerator<IActiveTextElem>;
    ///  <summary>Adds given element to active text object and returns index of
    ///  element in list.</summary>
    function AddElem(const Elem: IActiveTextElem): Integer;
    ///  <summary>Appends elements from another given active text object to the
    ///  current object.</summary>
    procedure Append(const ActiveText: IActiveText);
    ///  <summary>Returns a new IActiveText instance containing just the first
    ///  block of the current object.</summary>
    ///  <remarks>
    ///  <para>The first block is the content of the block level tag that starts
    ///  the active text. If this block has child blocks (for e.g. an unordered
    ///  list) then they are included.</para>
    ///  <para>If the current object is empty then an empty object is returned.
    ///  </para>
    ///  </remarks>
    function FirstBlock: IActiveText;
    ///  <summary>Checks if the active text object contains any elements.
    ///  </summary>
    function IsEmpty: Boolean;
    ///  <summary>Checks if the active text object has text content.</summary>
    function HasContent: Boolean;
    ///  <summary>Checks if the active text object contains only plain text.
    ///  </summary>
    ///  <remarks>Plain text is considered to be active text with no action
    ///  elements except for "document" or "block". This can rendered in plain
    ///  text with no loss of formatting.</remarks>
    function IsPlainText: Boolean;
    ///  <summary>Checks if the active text object is a valid active text
    ///  document.</summary>
    ///  <remarks>A valid document is either empty or it is surrounded by
    ///  matching ekDocument elements.</remarks>
    function IsValidActiveTextDocument: Boolean;
    ///  <summary>Returns element at given index in active text object's element
    ///  list.</summary>
    function GetElem(Idx: Integer): IActiveTextElem;
    ///  <summary>Returns number of elements in active text object's element
    ///  list.</summary>
    function GetCount: Integer;
    ///  <summary>Converts active text object into plain text.</summary<>
    function ToString: string;
    ///  <summary>List of elements in active text object.</summary>
    property Elems[Idx: Integer]: IActiveTextElem read GetElem; default;
    ///  <summary>Number of elements in element list.</summary>
    property Count: Integer read GetCount;
  end;

type
  ///  <summary>Interface supported by objects that can build an active text
  ///  object by parsing mark-up.</summary>
  ///  <remarks>Markup format is not specified: different implementations of
  ///  this interface may support different markup.</remarks>
  IActiveTextParser = interface(IInterface)
    ///  <summary>Parses markup and updates active text object accordingly.
    ///  </summary>
    ///  <param name="Markup">string [in] Markup that describes active text.
    ///  </param>
    ///  <param name="ActiveText">IActiveText [in] Active text object that is
    ///  updated by parser.</param>
    procedure Parse(const Markup: string; const ActiveText: IActiveText);
  end;

type
  ///  <summary>Class of exception raised when parsing active text markup.
  ///  </summary>
  EActiveTextParserError = class(EValidation);

type
  ///  <summary>Static factory class that can create instances of active text
  ///  objects and active text elements.</summary>
  TActiveTextFactory = class(TNoConstructObject)
  public
    ///  <summary>Returns a cloned copy of a given active text object.</summary>
    class function CloneActiveText(const Src: IActiveText): IActiveText;
    ///  <summary>Returns a new empty active text object.</summary>
    class function CreateActiveText: IActiveText; overload;
    ///  <summary>Returns an active text object with contents obtained by
    ///  parsing some markup.</summary>
    ///  <param name="Markup">string [in] Markup to be parsed.</param>
    ///  <param name="Parser">IActiveTextParser [in] Parser to be used to
    ///  parse markup.</param>
    ///  <returns>IActiveText. Active text object created from markup.</returns>
    class function CreateActiveText(const Markup: string;
      Parser: IActiveTextParser): IActiveText; overload;
    ///  <summary>Returns a new active text text element for given text.
    ///  </summary>
    class function CreateTextElem(const AText: string): IActiveTextTextElem;
    ///  <summary>Returns a new active text action element.</summary>
    ///  <param name="Kind">TActiveTextElemKind [in] Kind of element to be
    ///  created.</param>
    ///  <param name="Attrs">IActiveTextAttrs [in] Attributes of new element.
    ///  </param>
    ///  <param name="State">TActiveTextElemState [in] State of element (opening
    ///  or closing).</param>
    ///  <returns>IActiveTextActionElem. New element.</returns>
    class function CreateActionElem(const Kind: TActiveTextActionElemKind;
      Attrs: IActiveTextAttrs; const State: TActiveTextElemState):
      IActiveTextActionElem; overload;
    ///  <summary>Returns a new active text action element with no attributes.
    ///  </summary>
    ///  <param name="Kind">TActiveTextElemKind [in] Kind of element to be
    ///  created.</param>
    ///  <param name="State">TActiveTextElemState [in] State of element (opening
    ///  or closing).</param>
    ///  <returns>IActiveTextActionElem. New element.</returns>
    class function CreateActionElem(const Kind: TActiveTextActionElemKind;
      const State: TActiveTextElemState): IActiveTextActionElem; overload;
    ///  <summary>Returns a new empty active text attributes object.</summary>
    class function CreateAttrs: IActiveTextAttrs; overload;
    ///  <summary>Returns a new active text attributes object with the single
    ///  given attribute.</summary>
    class function CreateAttrs(Attr: TActiveTextAttr): IActiveTextAttrs;
      overload;
    ///  <summary>Returns a new active text attributes object containing all the
    ///  attributes from the given array.</summary>
    class function CreateAttrs(const Attrs: array of TActiveTextAttr):
      IActiveTextAttrs; overload;
  end;

type
  ///  <summary>Provides information about the capabilities of each supported
  ///  active text element.</summary>
  TActiveTextElemCaps = record
  strict private
    type
      ///  <summary>Fields used to define an active text element's capabilities.
      ///  </summary>
      TCaps = record
      public
        var
          ///  <summary>Determines how element is to be displayed.</summary>
          DisplayStyle: TActiveTextDisplayStyle;
          ///  <summary>Specifies whether plain text can be contained within the
          ///  element.</summary>
          PermitsText: Boolean;
          ///  <summary>Specifies the elements that are permitted as child
          ///  elements of this element.
          PermittedChildElems: TActiveTextActionElemKinds;
      end;
    const
      ///  <summary>Set of block level elements.</summary>
      BlockElems = [
        ekPara, ekHeading, ekUnorderedList, ekOrderedList, ekListItem,
        ekBlock, ekDocument
      ];
      ///  <summary>Set of block level elements that can directly contain text
      ///  and inline elements.</summary>
      TextContentBlocks = [
        ekPara, ekHeading, ekBlock
      ];
      ///  <summary>Set of block level elements that can contain only blocks
      ///  that are not container blocks.</summary>
      ContainerBlocks = [
        ekDocument, ekListItem
      ];
      ///  <summary>Set of inline elements.</summary>
      InlineElems = [
        ekLink, ekStrong, ekEm, ekVar, ekWarning, ekMono
      ];
      ///  <summary>Set of all elements.</summary>
      AllElems = BlockElems + InlineElems;
      ///  <summary>Map of all elements to their capabilities.</summary>
      Map: array[TActiveTextActionElemKind] of TCaps =
        (
          (
            // ekLink
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems - [ekLink];
          ),
          (
            // ekStrong
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekEm
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekVar
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekPara
            //   may contain any inline elements but no block elements
            DisplayStyle: dsBlock;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekWarning
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekHeading
            //   may contain any inline elements but no block elements
            DisplayStyle: dsBlock;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekMono
            //   may contain any inline elements but no block elements
            DisplayStyle: dsInline;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekUnorderedList
            //   may contain only list item elements
            DisplayStyle: dsBlock;
            PermitsText: False;
            PermittedChildElems: [ekListItem];
          ),
          (
            // ekOrderedList
            //   may contain only list item elements
            DisplayStyle: dsBlock;
            PermitsText: False;
            PermittedChildElems: [ekListItem];
          ),
          (
            // ekListItem
            //   may contain only block elements, but not itself or other
            //   block containers
            DisplayStyle: dsBlock;
            PermitsText: False;
            PermittedChildElems: BlockElems - ContainerBlocks;
          ),
          (
            // ekBlock
            //   may contain any inline elements but no block elements
            DisplayStyle: dsBlock;
            PermitsText: True;
            PermittedChildElems: InlineElems;
          ),
          (
            // ekDocument
            //   may contain only block elements, but not itself or other
            //   block containers
            DisplayStyle: dsBlock;
            PermitsText: False;
            PermittedChildElems: BlockElems - ContainerBlocks;
          )
        );
  public
    ///  <summary>Returns the display type of the given element.</summary>
    class function DisplayStyleOf(const Elem: TActiveTextActionElemKind):
      TActiveTextDisplayStyle; static;
    ///  <summary>Checks whether the given element can contain text.</summary>
    class function CanContainText(const Elem: TActiveTextActionElemKind):
      Boolean; static;
    ///  <summary>Checks whether the given child element is permitted as a child
    ///  of the given parent element.</summary>
    class function IsPermittedChildElem(
      const Parent, Child: TActiveTextActionElemKind): Boolean; static;
  end;


implementation


uses
  // Delphi
  SysUtils,
  // Project
  IntfCommon,
  UConsts,
  UStrUtils,
  UUtils;


type
  ///  <summary>Active text object implementation.</summary>
  TActiveText = class(TInterfacedObject,
    IActiveText, IAssignable, IClonable
  )
  strict private
    ///  <summary> List of active text elements.</summary>
    fElems: TList<IActiveTextElem>;
  public
    ///  <summary>Object constructor. Sets up object.</summary>
    constructor Create;
    ///  <summary>Object destructor. Tears down object.</summary>
    destructor Destroy; override;
    ///  <summary>Assigns properties of another object to this object.</summary>
    ///  <param name="Src">IInterface [in] Object whose properties are to be
    ///  assigned. Src must support IActiveText but may be nil.</param>
    ///  <remarks>
    ///  <para>Method of IAssignable.</para>
    ///  <para>If Src is nil, all this object's properties are cleared.</para>
    ///  <para>Raises EBug if Src is not nil and does not support IActiveText.
    ///  </para>
    ///  </remarks>
    procedure Assign(const Src: IInterface);
    ///  <summary>Returns a cloned instance of this object.</summary>
    ///  <remarks>Method of IClonable.</remarks>
    function Clone: IInterface;
    ///  <summary>Gets enumerator for contents of element list.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function GetEnumerator: TEnumerator<IActiveTextElem>;
    ///  <summary>Adds given element to element list and returns index of
    ///  element in list.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function AddElem(const Elem: IActiveTextElem): Integer;
    ///  <summary>Appends elements from given active text object to this one.
    ///  </summary>
    ///  <remarks>Method of IActiveText.</remarks>
    procedure Append(const ActiveText: IActiveText);
    ///  <summary>Returns a new IActiveText instance containing just the first
    ///  block of the current object.</summary>
    ///  <remarks>
    ///  <para>The first block is the content of the block level tag that starts
    ///  the active text. If this block has child blocks (for e.g. an unordered
    ///  list) then they are included.</para>
    ///  <para>If the current object is empty then an empty object is returned.
    ///  </para>
    ///  <para>Method of IActiveText.</para>
    ///  </remarks>
    function FirstBlock: IActiveText;
    ///  <summary>Checks if the element list is empty.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function IsEmpty: Boolean;
    ///  <summary>Checks if the active text object has text content.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function HasContent: Boolean;
    ///  <summary>Checks if the active text object contains only plain text.
    ///  </summary>
    ///  <remarks>
    ///  <para>Plain text is considered to be active text with no action
    ///  elements except for "document" or "block". This can rendered in plain
    ///  text with no loss of formatting.</para>
    ///  <para>Method of IActiveText.</para>
    ///  </remarks>
    function IsPlainText: Boolean;
    ///  <summary>Checks if the active text object is a valid active text
    ///  document.</summary>
    ///  <remarks>
    ///  <para>A valid document is either empty or it is surrounded by matching
    ///  ekDocument elements.</para>
    ///  <para>Method of IActiveText.</para>
    ///  </remarks>
    function IsValidActiveTextDocument: Boolean;
    ///  <summary>Returns element at given index in element list.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function GetElem(Idx: Integer): IActiveTextElem;
    ///  <summary>Returns number of elements element list.</summary>
    ///  <remarks>Method of IActiveText.</remarks>
    function GetCount: Integer;
    ///  <summary>Converts active text object into plain text.</summary<>
    ///  <remarks>Method of IActiveText.</remarks>
    function ToString: string; override;
  end;

type
  ///  <summary>Implements an active text plain text element.</summary>
  TActiveTextTextElem = class(TInterfacedObject,
    IActiveTextElem, IActiveTextTextElem, IAssignable, IClonable
  )
  strict private
    ///  <summary>Element's text.</summary>
    fText: string;
  public
    ///  <summary>Object constructor. Records given element text and sets
    ///  required Elem for a text element.</summary>
    constructor Create(const Text: string);
    ///  <summary>Assigns properties of another object to this object.</summary>
    ///  <param name="Src">IInterface [in] Object whose properties are to be
    ///  assigned. Src must support IActiveTextTextElem.</param>
    ///  <remarks>Method of IAssignable.</remarks>
    procedure Assign(const Src: IInterface);
    ///  <summary>Returns a cloned instance of this object.</summary>
    ///  <remarks>Method of IClonable.</remarks>
    function Clone: IInterface;
    ///  <summary>Returns plain text represented by element.</summary>
    ///  <remarks>Method of IActiveTextTextElem.</remarks>
    function GetText: string;
  end;

type
  ///  <summary>Implements an active text action element.</summary>
  TActiveTextActionElem = class(TInterfacedObject,
    IActiveTextElem, IActiveTextActionElem, IAssignable, IClonable
  )
  strict private
    ///  <summary>Elem of element encapsulated by this object.</summary>
    fKind: TActiveTextActionElemKind;
    ///  <summary>State of element: opening or closing.</summary>
    fState: TActiveTextElemState;
    ///  <summary>Attributes associated with element.</summary>
    fAttrs: IActiveTextAttrs;
  public
    ///  <summary>Object constructor. Creates an action element.</summary>
    ///  <param name="AKind">TActiveTextElemKind [in] Required Elem of element.
    ///  </param>
    ///  <param name="AAttrs">IActiveTextAttrs [in] Element's attributes.
    ///  </param>
    ///  <param name="AState">TActiveTextElemState [in] State of element:
    ///  opening or closing.</param>
    constructor Create(const AKind: TActiveTextActionElemKind;
      AAttrs: IActiveTextAttrs; const AState: TActiveTextElemState);
    ///  <summary>Assigns properties of another object to this object.</summary>
    ///  <param name="Src">IInterface [in] Object whose properties are to be
    ///  assigned. Src must support IActiveTextActionElem.</param>
    ///  <remarks>
    ///  <para>Method of IAssignable.</para>
    ///  <para>Raises EBug if Src does not support IActiveTextActionElem.</para>
    ///  </remarks>
    procedure Assign(const Src: IInterface);
    ///  <summary>Returns a cloned instance of this object.</summary>
    ///  <remarks>Method of IClonable.</remarks>
    function Clone: IInterface;
    ///  <summary>Returns Elem of action represented by this element.</summary>
    ///  <remarks>Method of IActiveTextActionElem.</remarks>
    function GetKind: TActiveTextActionElemKind;
    ///  <summary>Returns state of element.</summary>
    ///  <remarks>Method of IActiveTextActionElem.</remarks>
    function GetState: TActiveTextElemState;
    ///  <summary>Returns object describing element's attributes.</summary>
    ///  <remarks>Method of IActiveTextActionElem.</remarks>
    function GetAttrs: IActiveTextAttrs;
  end;

type
  ///  <summary>Implements an object that encapsulates a set of active text
  ///  attributes.</summary>
  TActiveTextAttrs = class(TInterfacedObject,
    IActiveTextAttrs, IAssignable, IClonable
  )
  strict private
    ///  <summary>Map of attribute names to values.</summary>
    fMap: TDictionary<string,string>;
  public
    ///  <summary>Object constructor. Sets up empty attributes object.</summary>
    constructor Create;
    ///  <summary>Object destructor. Tears down object.</summary>
    destructor Destroy; override;
    ///  <summary>Returns value of named attribute.</summary>
    ///  <remarks>
    ///  <para>Method of IActiveTextAttrs.</para>
    ///  <para>Exception raised if no such attribute exists.</para>
    ///  </remarks>
    function GetAttr(const Name: string): string;
    ///  <summary>Returns number of attributes.</summary>
    ///  <remarks>Method of IActiveTextAttrs.</remarks>
    function Count: Integer;
    ///  <summary>Records the value of a named attribute.</summary>
    ///  <remarks>
    ///  <para>Method of IActiveTextAttrs.</para>
    ///  <para>Any existing value with same name is overwritten.</para>
    ///  </remarks>
    procedure Add(const Name, Value: string);
    ///  <summary>Returns a new attribute enumerator.</summary>
    ///  <remarks>
    ///  <para>Method of IActiveTextAttrs.</para>
    ///  <para>Caller is responsible for freeing the enumerator.</para>
    ///  </remarks>
    function GetEnumerator: TEnumerator<TActiveTextAttr>;
    ///  <summary>Assigns properties of another object to this object.</summary>
    ///  <param name="Src">IInterface [in] Object whose properties are to be
    ///  assigned. Src must support IActiveTextAttrs.</param>
    ///  <remarks>Method of IAssignable.</remarks>
    procedure Assign(const Src: IInterface);
    ///  <summary>Returns a cloned instance of this object.</summary>
    ///  <remarks>Method of IClonable.</remarks>
    function Clone: IInterface;
  end;

{ TActiveTextFactory }

class function TActiveTextFactory.CloneActiveText(
  const Src: IActiveText): IActiveText;
begin
  Result := CreateActiveText;
  (Result as IAssignable).Assign(Src);
end;

class function TActiveTextFactory.CreateActionElem(
  const Kind: TActiveTextActionElemKind; Attrs: IActiveTextAttrs;
  const State: TActiveTextElemState): IActiveTextActionElem;
begin
  Result := TActiveTextActionElem.Create(Kind, Attrs, State);
end;

class function TActiveTextFactory.CreateActionElem(
  const Kind: TActiveTextActionElemKind;
  const State: TActiveTextElemState): IActiveTextActionElem;
begin
  Result := CreateActionElem(Kind, TActiveTextAttrs.Create, State);
end;

class function TActiveTextFactory.CreateActiveText: IActiveText;
begin
  Result := TActiveText.Create;
end;

class function TActiveTextFactory.CreateActiveText(const Markup: string;
  Parser: IActiveTextParser): IActiveText;
begin
  Result := CreateActiveText;
  Parser.Parse(Markup, Result);
end;

class function TActiveTextFactory.CreateAttrs(
  const Attrs: array of TActiveTextAttr): IActiveTextAttrs;
var
  Attr: TActiveTextAttr;
begin
  Result := TActiveTextAttrs.Create;
  for Attr in Attrs do
    Result.Add(Attr.Key, Attr.Value);
end;

class function TActiveTextFactory.CreateAttrs(Attr: TActiveTextAttr):
  IActiveTextAttrs;
begin
  Result := CreateAttrs([Attr]);
end;

class function TActiveTextFactory.CreateAttrs: IActiveTextAttrs;
begin
  Result := TActiveTextAttrs.Create;
end;

class function TActiveTextFactory.CreateTextElem(
  const AText: string): IActiveTextTextElem;
begin
  Result := TActiveTextTextElem.Create(AText);
end;

{ TActiveText }

function TActiveText.AddElem(const Elem: IActiveTextElem): Integer;
begin
  Result := fElems.Add(Elem);
end;

procedure TActiveText.Append(const ActiveText: IActiveText);

  function IsDocumentElem(Elem: IActiveTextElem): Boolean;
  var
    ActiveElem: IActiveTextActionElem;
  begin
    if not Supports(Elem, IActiveTextActionElem, ActiveElem) then
      Exit(False);
    Result := ActiveElem.Kind = ekDocument;
  end;

var
  Elem: IActiveTextElem;  // references each element in elems
  SelfCopy: IActiveText;  // temporary copy of this object
begin
  // *** Don't call Clone or Assign here: they call backinto this method.

  // Make a copy of elements of self
  SelfCopy := TActiveText.Create;
  for Elem in fElems do
    SelfCopy.AddElem((Elem as IClonable).Clone as IActiveTextElem);

  // Clear own elems and add document start element
  fElems.Clear;
  AddElem(TActiveTextFactory.CreateActionElem(ekDocument, fsOpen));

  // Copy own elements back to fElems, skipping ekDocument elems
  for Elem in SelfCopy do
    if not IsDocumentElem(Elem) then
      AddElem((Elem as IClonable).Clone as IActiveTextElem);

  // Copy active text to be assigned, skipping its ekDocument elems
  for Elem in ActiveText do
    if not IsDocumentElem(Elem) then
      AddElem((Elem as IClonable).Clone as IActiveTextElem);

  // Add closing ekDocument Elem
  AddElem(TActiveTextFactory.CreateActionElem(ekDocument, fsClose));
end;

procedure TActiveText.Assign(const Src: IInterface);
begin
  if Assigned(Src) and not Supports(Src, IActiveText) then
    raise EBug.Create(ClassName + '.Assign: Src must support IActiveText');
  fElems.Clear;
  if Assigned(Src) then
    Append(Src as IActiveText);
end;

function TActiveText.Clone: IInterface;
begin
  Result := TActiveText.Create;
  (Result as IAssignable).Assign(Self);
end;

constructor TActiveText.Create;
begin
  inherited Create;
  fElems := TList<IActiveTextElem>.Create;
end;

destructor TActiveText.Destroy;
begin
  fElems.Free;
  inherited;
end;

function TActiveText.FirstBlock: IActiveText;
var
  Elem: IActiveTextElem;
  ActionElem: IActiveTextActionElem;
  Block: IActiveTextActionElem;
  Idx: Integer;
  EndOfBlockFound: Boolean;
  HasDocElems: Boolean;
  FirstBlockIdx: Integer;
begin
  Result := TActiveText.Create;
  if IsEmpty then
    Exit;

  HasDocElems := IsValidActiveTextDocument;
  if HasDocElems then
  begin
    // We have ekDocument elements wrapping document: 1st true blue should be
    // next element
    if GetCount < 4 then
      Exit;
    FirstBlockIdx := 1;
  end
  else
  begin
    // No ekDocument elements: 1st true block is should be first element
    if GetCount < 2 then
      Exit;
    FirstBlockIdx := 0;
  end;

  // Element at FirstBlockIdx must be a valid block opening element
  Elem := GetElem(FirstBlockIdx);
  GetIntf(Elem, IActiveTextElem, Block);
  if not Assigned(Block)
    or (TActiveTextElemCaps.DisplayStyleOf(Block.Kind) <> dsBlock)
    or (Block.State <> fsOpen) then
    raise EBug.Create(
      ClassName + '.FirstBlock: block opener expected after ekDocument element'
    );

  // We have required block: add document opener element and block element
  Result.AddElem(TActiveTextFactory.CreateActionElem(ekDocument, fsOpen));
  Result.AddElem(Elem);

  // Scan through remaining elements, copying them to output as we go. Halt when
  // (or if) matching closing block found.
  EndOfBlockFound := False;
  Idx := Succ(FirstBlockIdx);
  while Idx < Pred(GetCount) do
  begin
    Elem := GetElem(Idx);
    Result.AddElem(Elem);
    if Supports(Elem, IActiveTextActionElem, ActionElem)
      and (ActionElem.Kind = Block.Kind)
      and (ActionElem.State = fsClose) then
    begin
      EndOfBlockFound := True;
      Break;
    end;
    Inc(Idx);
  end;
  // No closing block found
  if not EndOfBlockFound then
    raise EBug.Create(
      ClassName + '.FirstBlock: Matching closer for first block not found'
    );

  // Add document close elem (closing block elem added in loop above)
  Result.AddElem(TActiveTextFactory.CreateActionElem(ekDocument, fsClose));
end;

function TActiveText.GetCount: Integer;
begin
  Result := fElems.Count;
end;

function TActiveText.GetElem(Idx: Integer): IActiveTextElem;
begin
  Result := fElems[Idx];
end;

function TActiveText.GetEnumerator: TEnumerator<IActiveTextElem>;
begin
  Result := fElems.GetEnumerator;
end;

function TActiveText.HasContent: Boolean;
var
  Elem: IActiveTextElem;
  TextElem: IActiveTextTextElem;
begin
  Result := False;
  for Elem in fElems do
    if Supports(Elem, IActiveTextTextElem, TextElem)
      and (TextElem.Text <> '') then
      Exit(True);
end;

function TActiveText.IsEmpty: Boolean;
begin
  Result := fElems.Count = 0;
end;

function TActiveText.IsPlainText: Boolean;
var
  Elem: IActiveTextElem;
  ActionElem: IActiveTextActionElem;
begin
  for Elem in fElems do
  begin
    if Supports(Elem, IActiveTextActionElem, ActionElem)
      and not (ActionElem.Kind in [ekBlock, ekDocument]) then
      Exit(False);
  end;
  Result := True;
end;

function TActiveText.IsValidActiveTextDocument: Boolean;
var
  DocStartElem, DocEndElem: IActiveTextActionElem;
begin
  if IsEmpty then
    Exit(True);
  Result := (GetCount >= 2)
    and Supports(fElems[0], IActiveTextActionElem, DocStartElem)
    and (DocStartElem.Kind = ekDocument) and (DocStartElem.State = fsOpen)
    and Supports(fElems[Pred(GetCount)], IActiveTextActionElem, DocEndElem)
    and (DocEndElem.Kind = ekDocument) and (DocEndElem.State = fsClose);
end;

function TActiveText.ToString: string;
var
  Elem: IActiveTextElem;
  TextElem: IActiveTextTextElem;
  ActionElem: IActiveTextActionElem;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    for Elem in fElems do
    begin
      if Supports(Elem, IActiveTextTextElem, TextElem) then
        SB.Append(TextElem.Text);
      if Supports(Elem, IActiveTextActionElem, ActionElem)
        and (TActiveTextElemCaps.DisplayStyleOf(ActionElem.Kind) = dsBlock)
        and (ActionElem.State = fsClose) then
        // new line at end of block to separate text at end of closing block
        // from text at start of following block
        SB.AppendLine;
    end;
    Result := StrTrimRight(SB.ToString) + EOL;  // ensure single final EOL(s)
  finally
    SB.Free;
  end;
end;

{ TActiveTextTextElem }

procedure TActiveTextTextElem.Assign(const Src: IInterface);
begin
  fText := (Src as IActiveTextTextElem).Text;
end;

function TActiveTextTextElem.Clone: IInterface;
begin
  Result := TActiveTextTextElem.Create(fText);
  (Result as IAssignable).Assign(Self);
end;

constructor TActiveTextTextElem.Create(const Text: string);
begin
  inherited Create;
  fText := Text;
end;

function TActiveTextTextElem.GetText: string;
begin
  Result := fText;
end;

{ TActiveTextActionElem }

procedure TActiveTextActionElem.Assign(const Src: IInterface);
var
  SrcElem: IActiveTextActionElem;
begin
  if not Supports(Src, IActiveTextActionElem, SrcElem) then
    raise EBug.Create(ClassName + '.Assign: Src is not IActiveTextActionElem');
  fKind := SrcElem.Kind;
  fState := SrcElem.State;
  (SrcElem.Attrs as IAssignable).Assign(SrcElem.Attrs);
end;

function TActiveTextActionElem.Clone: IInterface;
var
  Attrs: IActiveTextAttrs;
begin
  Attrs := (fAttrs as IClonable).Clone as IActiveTextAttrs;
  Result := TActiveTextActionElem.Create(GetKind, Attrs, GetState);
end;

constructor TActiveTextActionElem.Create(const AKind: TActiveTextActionElemKind;
  AAttrs: IActiveTextAttrs; const AState: TActiveTextElemState);
begin
  inherited Create;
  fAttrs := AAttrs;
  fState := AState;
  fKind := AKind;
end;

function TActiveTextActionElem.GetAttrs: IActiveTextAttrs;
begin
  Result := fAttrs;
end;

function TActiveTextActionElem.GetKind: TActiveTextActionElemKind;
begin
  Result := fKind;
end;

function TActiveTextActionElem.GetState: TActiveTextElemState;
begin
  Result := fState;
end;

{ TActiveTextAttrs }

procedure TActiveTextAttrs.Add(const Name, Value: string);
begin
  fMap.Add(Name, Value);
end;

procedure TActiveTextAttrs.Assign(const Src: IInterface);
var
  Attr: TActiveTextAttr;
begin
  fMap.Clear;
  for Attr in (Src as IActiveTextAttrs) do
    fMap.Add(Attr.Key, Attr.Value);
end;

function TActiveTextAttrs.Clone: IInterface;
begin
  Result := TActiveTextAttrs.Create;
  (Result as IAssignable).Assign(Self);
end;

function TActiveTextAttrs.Count: Integer;
begin
  Result := fMap.Count;
end;

constructor TActiveTextAttrs.Create;
begin
  inherited Create;
  fMap := TDictionary<string,string>.Create;
end;

destructor TActiveTextAttrs.Destroy;
begin
  fMap.Free;
  inherited;
end;

function TActiveTextAttrs.GetAttr(const Name: string): string;
begin
  Result := fMap[Name];
end;

function TActiveTextAttrs.GetEnumerator: TEnumerator<TPair<string, string>>;
begin
  Result := fMap.GetEnumerator;
end;

{ TActiveTextElemCapsMap }

class function TActiveTextElemCaps.CanContainText(
  const Elem: TActiveTextActionElemKind): Boolean;
begin
  Result := Map[Elem].PermitsText;
end;

class function TActiveTextElemCaps.DisplayStyleOf(
  const Elem: TActiveTextActionElemKind): TActiveTextDisplayStyle;
begin
  Result := Map[Elem].DisplayStyle;
end;

class function TActiveTextElemCaps.IsPermittedChildElem(
  const Parent, Child: TActiveTextActionElemKind): Boolean;
begin
  Result := Child in Map[Parent].PermittedChildElems;
end;

end.


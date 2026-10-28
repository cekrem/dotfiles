# Developer Skills Guide: Best Practices from Lovdata Proto Frontend

This document captures the strong patterns and skills demonstrated by the Lovdata Proto frontend team, particularly focusing on work by Robin Heggelund Hansen, Magnus Rundberget, and Christian Ekrem. These are their best practices - skills to emulate in future projects.

## Developer Profiles

**Robin Heggelund Hansen** - *The Performance Engineer*
- Systematic performance optimization and render elimination
- Deep browser internals knowledge
- TypeScript/Elm interop expertise

**Magnus Rundberget** - *The Integration Expert*  
- Backend/frontend integration and error handling
- Production-aware development (timeouts, retries, logging)
- Incremental refactoring and feature flag management

**Christian Ekrem** - *The State Modeling Master*
- World-class state machine design with recursive types
- Type-driven UI development
- UX polish and accessibility awareness

## Table of Contents
1. [Architecture & Design Principles](#architecture--design-principles)
2. [Performance Optimization](#performance-optimization)
3. [Type Safety & Domain Modeling](#type-safety--domain-modeling)
4. [State Modeling Excellence](#state-modeling-excellence)
5. [API Design & Effect Systems](#api-design--effect-systems)
6. [Module Organization](#module-organization)
7. [Testing Philosophy](#testing-philosophy)
8. [UI Components & Accessibility](#ui-components--accessibility)
9. [Browser Interop & Ports](#browser-interop--ports)
10. [Code Quality & Maintainability](#code-quality--maintainability)
11. [Incremental Improvements](#incremental-improvements)

---

## Architecture & Design Principles

### 1. **Clean Separation of Concerns**
The codebase demonstrates excellent layering and separation:

- **Effect Layer**: Custom `Effect` module wraps Elm's `Cmd` system, providing a clean abstraction over side effects
- **Model-View-Update Pattern**: Strict adherence to The Elm Architecture with clear boundaries
- **Domain-Specific Types**: Types like `RemoteDataDetailed.WebData a` extend standard patterns with domain needs
- **Shared State Management**: Global state in `Shared.elm` with clear propagation patterns

**Example Pattern:**
```elm
-- Effects are explicitly typed and composable
batch : List (Effect msg) -> Effect msg

-- Effects can be added to existing tuples cleanly
add : Effect msg -> ( a, Effect msg ) -> ( a, Effect msg )
```

### 2. **Progressive Enhancement & Graceful Degradation**
- Features work across different devices (mobile/desktop)
- Careful handling of browser capabilities (e.g., `supportsContentVisibility` flag)
- Operating system and browser detection for tailored experiences
- Display mode awareness (standalone PWA vs browser)

### 3. **Defensive Programming Without Paranoia**
- Default values for potentially missing data
- Explicit handling of edge cases without over-engineering
- `Result` and `Maybe` types used appropriately (not excessively)
- Clear error boundaries with typed error states

---

## Performance Optimization

### 1. **Minimize Re-renders** (Robin's Expertise)
Robin demonstrates exceptional skill in identifying and eliminating unnecessary renders:

**Key Techniques:**
- **Avoid full document re-renders**: Track which parts of the document tree actually changed
- **Prepped nodes**: Pre-process expensive computations once using `PreppedNode` types
- **Indexed lookups**: Use `Dict String IndexedPartId` instead of list traversals
- **Offset tracking**: Maintain text offsets to avoid recalculating positions

**Example from DocumentMainTags:**
```elm
-- Stats computed once, reused throughout
type alias Stats =
    { indexedPartIds : Dict String IndexedPartId
    , footnotes : Dict String Footnote  
    , mainTagOffsets : List { maxOffset : Int, mainTagId : Int }
    }
```

### 2. **Strategic Computation Caching**
- Stats computed once during document load
- Part menus pre-computed and stored
- Viewport state cached and only updated on scroll
- Text offsets maintained incrementally

### 3. **DOM Optimization**
- Use of `content-visibility: auto` when browser supports it
- Minimize attribute de-duplication work
- Strategic use of keyed vs unkeyed nodes
- Custom elements for complex interactive components

### 4. **Code Comments on Performance**
```elm
-- elm-review: IGNORE TCO (this is a tree transformation, 
-- and the space complexity is proportional to the tree size anyway)
```
Clear communication about performance trade-offs!

---

## Type Safety & Domain Modeling

### 1. **State Machines with Custom Types** (Christian's Specialty)
Christian demonstrates masterful state modeling with the SearchField component:

```elm
type Model
    = Search String (Maybe Model)        -- Regular search with optional history
    | Question String Bool (Maybe Model) -- AI question with disclaimer flag and history
```

**Why this is brilliant:**
- **Impossible states are impossible**: Can't have a disclaimer on Search mode
- **History management**: The `Maybe Model` creates a state stack for toggling
- **Type-driven behavior**: Each constructor dictates different UI and validation
- **Self-documenting**: The type tells you exactly what's possible

**State Transitions:**
```elm
toggle : Model -> Model
toggle model =
    case model of
        Search _ (Just prev) ->
            prev |> withPrev model  -- Restore previous, remember current
        
        Question _ _ (Just prev) ->
            prev |> withPrev model
        
        Search _ Nothing ->
            Question "" True (Just model)  -- Switch to AI, show disclaimer
        
        Question _ _ Nothing ->
            Search "" (Just model)  -- Switch to search
```

This creates a **reversible state machine** - you can always go back to your previous mode with state intact!

**Validation at the type level:**
```elm
isInvalid : Model -> Bool
isInvalid state =
    case state of
        Question str _ _ ->
            String.isEmpty str  -- AI questions can't be empty
        _ ->
            False  -- Search can be empty (becomes "*")
```

### 2. **Opaque Types for Domain Concepts**
Strong use of opaque types to enforce business rules:

```elm
type EntryID = EntryID EntryType Int
type DocumentURI = DocumentURI { base : String, formatOrId : String, ... }
type SelectionID = SelectionID Int
```

**Benefits:**
- Impossible to mix up IDs of different types
- Compiler catches domain rule violations
- Refactoring is safe - the compiler guides you

### 2. **Exhaustive Pattern Matching**
Every case statement handles all possibilities explicitly:

```elm
case documentResponse of
    DocumentLoading maybeMetadata maybeContent ->
        -- handle loading
    
    DocumentSuccess data ->
        -- handle success
    
    DocumentFailure error ->
        -- handle failure
```

No `_` catch-alls unless truly justified with a comment.

### 3. **Cohesive Page Models** (Christian's Homepage)
Christian's homepage model shows excellent composition:

```elm
type alias Model =
    { notifications : RemoteDataDetailed.WebData NotificationResult
    , notificationStats : RemoteDataDetailed.WebData Notification.Stats
    , breadcrumbs : RemoteDataDetailed.WebData (List Breadcrumb)
    , mostUsedDocs : RemoteDataDetailed.WebData (List Breadcrumb)
    , latestHRDocs : RemoteDataDetailed.WebData SearchResult
    , legalAreas : Dict String LegalArea
    , headerModel : MainLayout.Model
    
    -- New homepage features:
    , annotations : RemoteDataDetailed.WebData AnnotationsResponse
    , activeFeedTab : FeedTab  -- Simple custom type for tab state
    , searchFieldModel : SearchField.Model  -- Delegated to child component
    , articles : RemoteDataDetailed.WebData (List Article)
    }

type FeedTab = HRA | Annotations | Notifications
```

**Key Principles:**
- **RemoteData everywhere**: Every async data source has explicit loading/error states
- **Child model composition**: `searchFieldModel` and `headerModel` delegate complex state
- **Simple enums**: `FeedTab` is just what it needs to be
- **Comments for sections**: Clearly marks old vs new features

**Benefits:**
- Easy to extend (add new remote data sources)
- Impossible to forget loading/error states
- Child components manage their own complexity
- Clear separation of concerns

### 4. **Smart Constructors and Builders**
The Icon and Button components showcase excellent builder patterns:

```elm
-- Start with sensible defaults
new : Fn msg -> IconOptions msg

-- Chain modifications
withSize : Size -> IconOptions msg -> IconOptions msg
withAriaLabel : String -> IconOptions msg -> IconOptions msg
withButtonInteraction : String -> msg -> IconOptions msg -> IconOptions msg

-- Build the final result
build : IconOptions msg -> Html msg
```

### 4. **Type-Driven Development**
Types guide the implementation:

```elm
-- The type tells the complete story
truncateNodes : List Node -> Int -> { nodes : List Node, didTruncateText : Bool }
```

---

## State Modeling Excellence

Christian Ekrem demonstrates world-class state modeling skills throughout the codebase. His approach to modeling UI state is a masterclass in type-driven design.

### 1. **The SearchField Pattern: Recursive State with History**

The `Components.Homepage.SearchField` is perhaps the best example of elegant state modeling in the entire codebase:

```elm
type Model
    = Search String (Maybe Model)
    | Question String Bool (Maybe Model)
```

**What makes this brilliant:**

1. **Two modes are crystal clear**: Search vs AI Question
2. **Each mode has its own requirements**:
   - `Search` just needs the query string
   - `Question` needs query + disclaimer visibility flag
3. **History is built-in**: The `Maybe Model` creates a reversible state stack
4. **No invalid states**: Can't have a disclaimer on Search mode
5. **Self-documenting**: The type tells the complete story

**State transitions are pure functions:**

```elm
toggle : Model -> Model
toggle model =
    case model of
        -- Has previous state? Restore it
        Search _ (Just prev) -> prev |> withPrev model
        Question _ _ (Just prev) -> prev |> withPrev model
        
        -- No previous state? Create new mode with current as history
        Search _ Nothing -> Question "" True (Just model)
        Question _ _ Nothing -> Search "" (Just model)

-- Always preserve the chain
withPrev : Model -> Model -> Model
withPrev prev model =
    case model of
        Question q disclaimer _ ->
            Question q disclaimer (Just prev)
        Search q _ ->
            Search q (Just prev)
```

**This creates a perfect undo/redo system** without any explicit history management!

### 2. **Operations Preserve Invariants**

Every operation on the SearchField maintains the state chain:

```elm
setValue : String -> Model -> Model
setValue text model =
    case model of
        Search _ prev ->
            Search text prev  -- Preserve history
        
        Question _ showDisclaimer prev ->
            Question text showDisclaimer prev  -- Preserve history AND disclaimer

hideDisclaimer : Model -> Model
hideDisclaimer model =
    case model of
        Search _ _ ->
            model  -- No-op, search doesn't have disclaimers
        
        Question q _ prev ->
            Question q False prev  -- Only affects Question mode
```

**Key insight**: Operations are mode-aware. The type system ensures you handle each mode correctly.

### 3. **Validation at the Type Level**

Different modes have different validation rules:

```elm
isInvalid : Model -> Bool
isInvalid state =
    case state of
        Question str _ _ ->
            String.isEmpty str  -- AI questions MUST have content
        
        _ ->
            False  -- Search allows empty (becomes "*")

valueAndType : Model -> ( String, SearchType )
valueAndType model =
    case model of
        Search str _ ->
            ( if String.isEmpty str then "*" else str, LegalSources )
        
        Question str _ _ ->
            ( str, AI )
```

**The type drives the behavior** - no runtime checks for "what mode am I in?"

### 4. **Cohesive Page Models**

Christian's homepage model shows excellent composition:

```elm
type alias Model =
    { -- Remote data with explicit states
      notifications : RemoteDataDetailed.WebData NotificationResult
    , annotations : RemoteDataDetailed.WebData AnnotationsResponse
    , articles : RemoteDataDetailed.WebData (List Article)
    
    -- Simple enums for UI state
    , activeFeedTab : FeedTab
    
    -- Delegated complex state
    , searchFieldModel : SearchField.Model
    , headerModel : MainLayout.Model
    }

type FeedTab = HRA | Annotations | Notifications
```

**Principles demonstrated:**
- **RemoteData pattern**: Never forget loading/error states
- **Composition**: Complex components manage their own state
- **Simple types**: Don't over-engineer (FeedTab is just an enum)
- **Clear names**: Every field's purpose is obvious

### 5. **When to Use This Pattern**

Christian's recursive state pattern is perfect for:

- ✅ **Toggle-able UI modes** (tabs, search types, view modes)
- ✅ **Wizard flows** with back/forward navigation
- ✅ **Simple undo/redo** (one level of history)
- ✅ **Mode switching** where you want to preserve state
- ✅ **Mutually exclusive states** with different data

Avoid when:
- ❌ Need deep history (use a list instead)
- ❌ States are independent (use separate fields)
- ❌ Complex state transitions (use a proper state machine)

### 6. **Lessons from Christian's State Modeling**

**Think in states, not flags:**
```elm
-- Don't do this:
type alias Model = 
    { isAIMode : Bool
    , showDisclaimer : Bool
    , searchText : String
    , questionText : String
    , previousSearchText : String
    , previousQuestionText : String
    }

-- Do this:
type Model
    = Search String (Maybe Model)
    | Question String Bool (Maybe Model)
```

**Make transitions explicit:**
```elm
-- Each state transition is a named function
toggle : Model -> Model
setValue : String -> Model -> Model
hideDisclaimer : Model -> Model
```

**Let the type system work for you:**
```elm
-- Compiler ensures you handle all cases
case model of
    Search str prev -> -- Must handle Search
    Question str disclaimer prev -> -- Must handle Question
```

**State should be self-contained:**
- The SearchField doesn't depend on page state
- Can be used anywhere
- Easy to test
- Easy to reason about

### 7. **Comparison to Other Approaches**

**React/TypeScript equivalent would be:**
```typescript
type Model = 
  | { type: 'search', value: string, prev?: Model }
  | { type: 'question', value: string, showDisclaimer: boolean, prev?: Model }
```

**But Elm's approach is superior because:**
1. Pattern matching is exhaustive (compiler error if you forget a case)
2. No runtime type checks needed
3. Impossible to construct invalid states
4. Better IDE support (types guide you)

---

## API Design & Effect Systems

### 1. **Consistent Effect Patterns**
The `Effect` module is a masterclass in API design:

**Key Principles:**
- Clear, semantic function names (`pushRoute`, `scrollToID`, `focusElement`)
- Composable effects through `batch`
- Type safety - impossible to mix up parameters
- No exposed constructors - use smart constructors

```elm
-- Users can't construct invalid effects
scrollToMarking : { markingId : Int, panelId : String, panelMarkingId : String } -> Effect msg

-- Effects compose naturally
batch 
    [ scrollToMarking data
    , setScrollDirectionUp
    , documentLoaded
    ]
```

### 2. **Remote Data State Management**
Excellent extension of `RemoteData` pattern:

```elm
type alias WebData a = RemoteData HttpDetailedError (PayloadWithMeta a)

-- Includes HTTP metadata with every success
type alias PayloadWithMeta a = ( Http.Metadata, a )
```

**Benefits:**
- Always have access to response headers
- Can implement caching strategies
- Error responses include full HTTP context
- JSON error decoding (RFC 9457 Problem Details)

### 3. **Port Communication**
TypeScript interop is clean and type-safe:

```elm
-- Elm side: strongly typed messages
type ElmMsg
    = ChangeLanguage Language
    | ScrollToSelector ScrollOptions
    | GetViewportState
    -- ...

-- TypeScript side: validated message handling
elmEncoder : ElmMsg -> Json.Encode.Value
```

### 4. **Request Tracking**
API calls can be tracked and cancelled:

```elm
postWithTracker :
    { apiUrl : ApiUrl
    , tracker : Maybe String
    , -- ... other fields
    }
    -> Cmd msg
```

---

## Module Organization

### 1. **Consistent File Structure**
Clear patterns across the codebase:

```
Module/
  ├── Module.elm          -- Main public API
  ├── Module/
  │   ├── Api.elm         -- Backend communication
  │   ├── Types.elm       -- Domain types
  │   ├── Model.elm       -- State management
  │   ├── Update.elm      -- State transitions
  │   ├── View.elm        -- Rendering
  │   └── Subfeature.elm  -- Nested features
```

### 2. **Exposed vs Internal APIs**
Careful control of module exposure:

```elm
module Document.Model exposing
    ( Model            -- Expose the type
    , initModel        -- Expose constructor
    , setAnnotations   -- Expose mutations
    -- But not internal helpers
    )
```

### 3. **Utility Modules**
Focused utility modules with clear purposes:
- `Utils.List` - List operations
- `Utils.String` - String helpers  
- `Utils.Url` - URL manipulation
- `Libs.Node` - Generic tree operations
- `Libs.PreppedNode` - Domain-specific tree optimization

### 4. **Feature Toggles**
Clean feature flag system:

```elm
type alias FeatureFlags =
    { newHomepage : Bool
    , newSelections : Bool
    , aiSearchBanner : Bool
    -- ...
    }
```

---

## Testing Philosophy

### 1. **Test What Matters**
The test suite focuses on:
- Business logic (markings, selections, search)
- Data transformations (tree filtering, text truncation)
- Edge cases (empty lists, missing data)
- Domain rules (document URIs, offsets)

### 2. **Documentation Tests**
Use of `elm-verify-examples` to keep documentation in sync with reality.

### 3. **Property-Based Thinking**
Even without QuickCheck, tests show property-based thinking:

```elm
-- Test boundary conditions
test "DocumentBody anchor (cross-node)" <|
    \_ ->
        captureTextAtPosition testDoc
            { anchor = DocumentBody
            , offset = 10
            , length = 9
            }
            |> Expect.equal [ "test ", "from" ]
```

### 4. **Integration Tests**
Playwright E2E tests for critical user journeys:
- Authentication flows
- Document viewing and annotation
- Search functionality
- Selection management

---

## UI Components & Accessibility

### 1. **Accessibility First**
The Icon component documentation is exemplary:

```elm
{-| A label is required for Button and Link:
  - The label cannot be empty
  - The label must describe the function, not the graphical content
    (e.g. "Open menu" instead of "Three dots")
-}
```

Features:
- ARIA attributes properly used (`aria-label`, `aria-expanded`, `aria-controls`)
- Keyboard navigation support (`aria-keyshortcuts`)
- Screen reader considerations
- Focus management

### 2. **Progressive Disclosure**
Christian's work on collapsible components shows excellent UX thinking:
- Auto-expand on mobile, collapsible on desktop
- Remember user preferences
- Smooth animations with configurable durations
- Keyboard accessibility

### 3. **Responsive Design**
- Device classification (`Device.classifyDevice`)
- Breakpoint-aware components
- Mobile-first thinking with desktop enhancements
- Touch vs mouse interaction handling

### 4. **Dark Mode Support**
Systematic dark mode implementation:
- User preference stored
- System preference detection
- Tailwind classes: `dark:bg-cardinal06`
- Consistent color scheme throughout

---

## Browser Interop & Ports

### 1. **TypeScript Integration**
Robin and Magnus show excellent TypeScript interop skills:

**Key Patterns:**
- Type-safe message passing
- DOM manipulation in TypeScript, state in Elm
- Custom elements for complex widgets
- Service worker integration

**Example:**
```typescript
export function getViewportState(): ViewportState {
    const idLocations = idFinder();
    const mainElem = getDocumentContainer();
    const pixelsFromTop = mainElem?.scrollTop || 0;
    
    return {
        pixelsFromTop,
        scrollLocation: idLocations.scrollLocation,
        topVisiblePartId: idLocations.topVisiblePartId,
    };
}
```

### 2. **Custom Elements**
Strategic use of Web Components:
- `commentLineElement` - Interactive comment positioning
- `latexElement` - Math formula rendering  
- `verticalLineElement` - Document markers

### 3. **Scroll Management**
Sophisticated scroll handling:
- Restore scroll position after navigation
- Smooth vs instant scrolling
- Scroll to anchors with offset adjustment
- Viewport state tracking

---

## Code Quality & Maintainability

### 1. **Meaningful Comments**
Comments explain *why*, not *what*:

```elm
-- If the host is a private address we are most likely running locally.
-- Note that our internal servers also use private addresses, but they won't 
-- trigger here as long as we are using their dns names.

-- elm-review: IGNORE TCO (this is a tree transformation, and the 
-- space complexity is proportional to the tree size anyway)
```

### 2. **Commit Message Quality**
Clear, descriptive commit messages:
- `fix: Avoid closing Table of Contents when scrolling with the third grid column open`
- `perf: Remove duplicate remote calls in selection init`
- `refactor: Use relative line height for comment labels`

### 3. **Code Review Comments**
Evidence of thoughtful review process:
- `Review: Simplify` commits
- `Chore:` commits for housekeeping
- Feature flag removal after stabilization

### 4. **Technical Debt Management**
- TODO comments with context and links
- Feature flags for gradual rollout
- Deprecation paths for old code
- Systematic cleanup of unused code

### 5. **Naming Conventions**
Consistent, descriptive names:
- Functions: `scrollToMarking`, `filterMatchingLegalSources`
- Types: `DocumentMainTags`, `SearchResultStatus`
- Fields: `pixelsFromTop`, `topVisiblePartId`
- No abbreviations unless domain-standard

---

## Incremental Improvements

### 1. **Performance Profiling**
Robin's commits show systematic performance work:
- "Improve performance when rendering part menus by reducing copying"
- "Avoid a complete re-render when updating DocumentBody markings"  
- "Remove MainTag compensation and old search logic"

### 2. **Gradual Refactoring**
Magnus shows excellent incremental improvement:
- Breaking complex functions into helpers
- Extracting reusable patterns
- Improving error messages and logging
- Cleaning up after feature completion

### 3. **UX Polish**
Christian's work demonstrates attention to detail:
- "make hitboxes great again"
- "auto-focus search field after toggle"
- "fix: word-breaks and weird indent on home"
- "feat: auto-scale new search more liberally"

### 4. **State Modeling Excellence**
Christian shows exceptional skill in modeling complex UI state (see `Components.Homepage.SearchField`):
- Recursive state types with history
- Mode switching with state preservation
- Invalid state prevention at the type level
- Clean state transitions

### 4. **Developer Experience**
Thoughtful improvements for the team:
- Better error messages
- Clearer type names
- More helper functions
- Documentation updates

---

## Specific Patterns to Emulate

### 1. **Recursive State with History** (Christian's SearchField Pattern)
From `Components.Homepage.SearchField`:

```elm
-- Brilliant pattern: recursive type for reversible state
type Model
    = Search String (Maybe Model)
    | Question String Bool (Maybe Model)

-- Toggle preserves state both ways
toggle : Model -> Model
toggle model =
    case model of
        Search _ (Just prev) ->
            prev |> withPrev model
        
        Search _ Nothing ->
            Question "" True (Just model)
        
        Question _ _ (Just prev) ->
            prev |> withPrev model
        
        Question _ _ Nothing ->
            Search "" (Just model)

-- Helper to preserve history when transitioning
withPrev : Model -> Model -> Model
withPrev prev model =
    case model of
        Question q disclaimer _ ->
            Question q disclaimer (Just prev)
        
        Search q _ ->
            Search q (Just prev)
```

**Why this pattern rocks:**
- No separate history list needed
- Type-safe - can't access invalid history
- Clean API - just call `toggle`
- Works for N levels (could extend to more states)
- Efficient - only stores one previous state

**When to use:**
- Toggle-able UI modes (tabs, panels, views)
- Undo/redo for simple operations
- Wizard flows with back button
- Any reversible state transition

### 2. **Tree Operations**
From `LegalSource.TreeUtils`:

```elm
-- Mark nodes that match, then filter the tree in two passes
markTreeMatches : (LegalSource -> Bool) -> Tree LegalSource -> Tree ( LegalSource, Bool )
filterMarkedTree : Tree ( LegalSource, Bool ) -> Maybe (Tree LegalSource)

-- Elegant two-phase filtering preserves tree structure
filterMatchingLegalSources translations maybeQuery forest =
    forest
        |> List.map (markTreeMatches matcher)
        |> List.filterMap filterMarkedTree
```

### 2. **Offset Tracking**
From `Document.Offsets`:

```elm
-- Immutable, composable offset tracking
type alias Offsets = { documentBodyOffset : Int, partOffset : Maybe Int }

inc : Int -> Offsets -> Offsets
setPartId : String -> Offsets -> Offsets  
clearPartId : Offsets -> Offsets
```

### 3. **Builder Pattern**
From `Components.Button`:

```elm
primary : String -> msg -> Config msg
primary label onClick =
    Config
        { label = label
        , style = Primary
        , type_ = Button onClick
        , disabled = False
        , icon = None
        , iconPlacement = AfterText
        , attrs = []
        }

-- Chainable modifications
withIcon : IconFn msg -> Config msg -> Config msg
withAttrs : List (Attribute msg) -> Config msg -> Config msg
disabled : Bool -> Config msg -> Config msg

-- Single build function
view : Config msg -> Html msg
```

### 4. **RemoteData Enhancement**
From `RemoteDataDetailed`:

```elm
-- Extend RemoteData with HTTP metadata and detailed errors
type alias WebData a = 
    RemoteData HttpDetailedError (PayloadWithMeta a)

-- Helpers preserve the pattern
map : (a -> b) -> WebData a -> WebData b
map2 : (a -> b -> c) -> WebData a -> WebData b -> WebData c
withDefault : a -> WebData a -> a
```

### 5. **Search Term Safety**
From `Search.Implementation`:

```elm
type alias LegalSourcesModel =
    { searchTerm : String           -- What the UI shows
    , backingSearchTerm : String    -- What the user is typing
    -- ...
    }

-- Separate backing state from committed state
-- Prevents race conditions in search
```

### 6. **State Machine with History** (Christian's SearchField)
From `Components.Homepage.SearchField`:

```elm
type Model
    = Search String (Maybe Model)
    | Question String Bool (Maybe Model)

-- The Maybe Model creates a reversible state stack
-- Toggle between modes while preserving previous state

toggle : Model -> Model
setValue : String -> Model -> Model
hideDisclaimer : Model -> Model

-- Each function preserves the state history
-- Users can switch modes without losing their work
```

**Key insight:** Model UI modes as distinct states with shared operations. The recursive `Maybe Model` is elegant - it creates an implicit stack without list overhead.

---

## Anti-Patterns Avoided

### 1. **No Stringly-Typed Code**
The codebase avoids strings for types:
- ❌ `type alias UserID = String`
- ✅ `type UserID = UserID Int`

### 2. **No Implicit State**
All state is explicit:
- No global variables
- No hidden mutable state
- Clear data flow through Model

### 3. **No God Objects**
Modules stay focused:
- Document module handles documents
- Search module handles search
- Selection module handles selections
- No "Utils" dumping ground (utilities are organized)

### 4. **No Premature Abstraction**
Code shows restraint:
- Helpers extracted when pattern repeats
- Not before
- Comments explain why abstraction exists

### 5. **No Magic Numbers**
Named constants and semantic functions:
```elm
-- Good
defaultSearchRequestTracker : String
defaultSearchRequestTracker = "search_in_progress_tracker"

-- Instead of just using the string everywhere
```

---

## Technology-Specific Skills

### 1. **Elm-Specific**
- **Extensible records** for shared config
- **Phantom types** for additional compile-time safety
- **Opaque types** for encapsulation
- **Custom type constructors** for state machines
- **Port modules** for JS interop

### 2. **Tailwind CSS**
- Utility-first approach
- Dark mode with `dark:` prefix
- Custom design system in CSS variables
- Generated icon utilities

### 3. **Vite Build System**
- Fast development server
- TypeScript integration
- Service worker build
- Asset optimization

### 4. **Testing Stack**
- `elm-test-rs` for unit tests
- `elm-verify-examples` for doc tests
- Playwright for E2E
- `elm-review` for static analysis

---

## Wisdom from the Codebase

### Robin's Performance Wisdom
- "Avoid running checks and functions twice"
- "Reduce the amount of copying required"
- "Avoid a complete re-render of the document"
- Profile before optimizing, but when you optimize, optimize thoroughly

### Magnus's Integration Wisdom
- Improve error messages - they're user-facing
- Log at appropriate levels (don't spam WARN)
- Test edge cases, especially integration points
- Clean up feature flags after rollout

### Christian's UX & State Wisdom
- Auto-focus makes interfaces feel responsive
- Word-breaking and text overflow matter
- Hitboxes should be generous
- Dark mode is table stakes
- Model state transitions explicitly - don't leave them implicit
- Use types to prevent invalid states, not runtime checks
- State history/undo should be built into the model, not bolted on
- Each UI mode should map to a type constructor

---

## Checklist for New Features

When implementing a new feature, ask:

- [ ] Have I used the `Effect` system correctly?
- [ ] Are my types opaque where they should be?
- [ ] Have I tested edge cases?
- [ ] Is the API consistent with existing patterns?
- [ ] Are errors handled with proper types, not strings?
- [ ] Have I considered accessibility?
- [ ] Does this work on mobile?
- [ ] Does this work in dark mode?
- [ ] Is the performance acceptable?
- [ ] Are there any race conditions?
- [ ] Have I added appropriate comments for "why"?
- [ ] Is the commit message descriptive?

---

## Learning Resources

To understand the patterns better, study these files:

**Architecture:**
- `src/Effect.elm` - Effect system
- `src/Shared.elm` - Global state management
- `src/RemoteDataDetailed.elm` - Enhanced RemoteData

**Performance:**
- `src/Document/DocumentMainTags.elm` - Offset tracking
- `src/Document/View.elm` - Optimized rendering
- `src/Libs/PreppedNode.elm` - Pre-computation

**API Design:**
- `src/Api.elm` - HTTP client
- `src/Components/Button.elm` - Builder pattern
- `src/Components/Icon.elm` - Accessibility-first components

**Domain Modeling:**
- `src/Selection/Entry.elm` - Domain types
- `src/Document/DocumentURI.elm` - Opaque types
- `src/LegalSource/TreeUtils.elm` - Tree operations
- `src/Components/Homepage/SearchField.elm` - **State machines** (Christian's work)

---

## Conclusion

The Lovdata Proto frontend codebase demonstrates:

1. **Thoughtful architecture** - Clean boundaries, clear responsibilities
2. **Performance consciousness** - Systematic optimization where it matters (Robin)
3. **Type-driven development** - Let the compiler be your guide (Christian)
4. **State modeling excellence** - Impossible states made impossible (Christian)
5. **Accessibility first** - Build for everyone (Christian)
6. **Integration expertise** - Smooth frontend/backend collaboration (Magnus)
7. **Incremental improvement** - Make it better bit by bit (Magnus)
8. **Team collaboration** - Consistent patterns, thoughtful reviews

These skills transfer beyond Elm to any serious frontend application. The key is:
- **Think in types** - Model your domain first (Christian)
- **Make impossible states impossible** - Use the type system (Christian)
- **Profile before optimizing** - Then optimize ruthlessly (Robin)
- **Test what matters** - Edge cases and integration points (Magnus)
- **Write code for humans** - Clear names, helpful comments (All)
- **State machines > booleans** - Multiple booleans = state machine in disguise (Christian)
- **Composition > inheritance** - Build complex UIs from simple pieces (All)

---

*This document captures the team at their best. Use it as a north star for future projects.*

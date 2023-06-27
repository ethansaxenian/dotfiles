syntax keyword typescriptStorageClass const var let skipwhite skipempty nextgroup=typescriptDestructuringBlock,typescriptDestructuringArray,typescriptVariableDef
syntax match typescriptVariableDef contained /\<\K\k*/ skipwhite
syntax match   typescriptDestructuringPropertyValue     contained /\k\+/
syntax region  typescriptDestructuringBlock contained matchgroup=jsDestructuringBraces start=/{/  end=/}/ contains=jsDestructuringProperty,jsDestructuringAssignment,jsDestructuringNoise,jsDestructuringPropertyComputed,jsSpreadExpression,jsComment nextgroup=jsFlowDefinition extend fold
syntax region  typescriptDestructuringArray contained matchgroup=jsDestructuringBraces start=/\[/ end=/\]/ contains=jsDestructuringPropertyValue,jsDestructuringNoise,jsDestructuringProperty,jsSpreadExpression,jsDestructuringBlock,jsDestructuringArray,jsComment nextgroup=jsFlowDefinition extend fold
syntax match   jsFuncCall       /\<\K\k*\ze\s*(/

syntax keyword typescriptTypeStorageClass type interface skipwhite skipempty nextgroup=typescriptTypeDef
syntax match typescriptTypeDef contained /\<\K\k*/ skipwhite

syntax clear typescriptReserved

syntax clear typescriptGlobalObjects
syntax keyword typescriptGlobalObjects Array Boolean Date Function Infinity JSON Math Number NaN Object Packages RegExp String Symbol netscape ArrayBuffer BigInt64Array BigUint64Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray Buffer Collator DataView DateTimeFormat Intl Iterator Map Set WeakMap WeakSet NumberFormat ParallelArray Promise Proxy Reflect Uint8ClampedArray WebAssembly

syntax clear typescriptDOMObjects
syntax keyword typescriptDOMMethods render

syntax keyword typescriptBrowserKeywords process window navigator screen history location document event className

syntax clear typescriptGlobalNodeObjects
syntax keyword typescriptGlobalNodeObjects  module exports global __dirname __filename

syntax keyword ReactHooks useState useEffect useMemo useCallback
syntax keyword Events e event target value

syntax match typescriptArrowFunction "=>"


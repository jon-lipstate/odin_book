llvm doesnt opt odin - semantics disagree
eg int overflow:
uint32_t n = UINT32_MAX;
for (uint32_t i = 0; i < n; i++) {
...
}

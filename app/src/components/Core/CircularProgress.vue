<template>
  <div class="full">
    <v-progress-circular
      :size="50"
      color="primary"
      indeterminate
    ></v-progress-circular>
  </div>
</template>

<script>
export default {
  name: "CircularProgress",
};
</script>

<style scoped>
.full {
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background: transparent;
}
</style>
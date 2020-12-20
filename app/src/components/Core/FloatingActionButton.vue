<template>
  <v-tooltip bottom>
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        elevation="1"
        dark
        fab
        right
        top
        absolute
        v-on="on"
        v-bind="attrs"
        color="#FF6D6D"
        class="mt-6 mr-16"
        style="top: 0"
        @click="action()"
      >
        <v-icon large>{{ icon }}</v-icon>
      </v-btn>
    </template>
    <span>{{ text }}</span>
  </v-tooltip>
</template>

<script>
export default {
  name: "FloatingActionButton",
  props: {
    text: {
      type: String,
      required: true,
    },
    icon: {
      type: String,
      required: true,
    },
    action: {
      type: Function,
      required: true,
    },
  },
};
</script>

<style>
</style>
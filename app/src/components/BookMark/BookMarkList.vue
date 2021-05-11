<template>
  <section>
    <book-mark
      v-for="bookMark in getBookMarks"
      :key="bookMark.bookMarkId"
      :bookMark="bookMark"
    />
  </section>
</template>

<script>
import { mapGetters } from "vuex";
import BookMark from "./BookMark.vue";

export default {
  name: "BookMarkList",
  components: { BookMark },
  computed: {
    ...mapGetters("bookMark", ["getBookMarks"]),
  },
};
</script>

<style>
</style>